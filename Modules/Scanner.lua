local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule(
    'Scanner',
    {
        autoAccept = {},
        dungeons = {},
        pois = {},
        quests = {},
        questPaths = {},
        scanDungeons = {},
        scanPois = {},
    }
)


local CAPI_GetAreaPOIInfo = C_AreaPoiInfo.GetAreaPOIInfo
local CDAT_GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset
local CQL_GetQuestObjectives = C_QuestLog.GetQuestObjectives
local CQL_IsOnQuest = C_QuestLog.IsOnQuest
local CQL_IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local CQL_IsQuestFlaggedCompletedOnAccount = C_QuestLog.IsQuestFlaggedCompletedOnAccount
local CQL_IsWorldQuest = C_QuestLog.IsWorldQuest
local CTQ_GetQuestTimeLeftSeconds = C_TaskQuest.GetQuestTimeLeftSeconds
local CTSUI_GetProfessionInfoBySkillLineID = C_TradeSkillUI.GetProfessionInfoBySkillLineID

local DATA_TYPES = {
    'drops',
    'dungeons',
    'quests',
}
local OPTIONAL_OBJECTIVE = OPTIONAL_QUEST_OBJECTIVE_DESCRIPTION:gsub('%%s', '.+'):gsub('([%(%)])', '%%%1')
local STATUS_NOT_STARTED = 0
local STATUS_IN_PROGRESS = 1
local STATUS_COMPLETED = 2

function Module:OnEnable()
    self:RegisterEvent('QUEST_ACCEPTED')
    self:RegisterEvent('QUEST_REMOVED')
    self:RegisterEvent('QUEST_TURNED_IN')

    self:RegisterBucketEvent(
        {
            'SKILL_LINE_SPECS_RANKS_CHANGED',
            'SKILL_LINES_CHANGED',
            'TRADE_SKILL_SHOW',
        },
        1,
        'UpdateSkillLines'
    )
    self:RegisterBucketEvent(
        {
            'AREA_POIS_UPDATED',
        },
        2,
        'ScanPois'
    )
    self:RegisterBucketEvent(
        {
            'ENCOUNTER_LOOT_RECEIVED',
            'ITEM_PUSH',
            'QUEST_LOG_UPDATE', -- spammy quest log updates
        },
        2,
        'ScanQuests'
    )
    self:RegisterBucketEvent(
        {
            'UNIT_QUEST_LOG_CHANGED', -- spammy quest log updates part 2?
        },
        2,
        'UNIT_QUEST_LOG_CHANGED'
    )
    self:RegisterBucketEvent(
        {
            'LFG_COMPLETION_REWARD',
            'LFG_LOCK_INFO_RECEIVED',
            'LFG_UPDATE_RANDOM_INFO',
        },
        1,
        'ScanDungeons'
    )
end

function Module:OnEnteringWorld()
    local linesChanged = self:UpdateSkillLines()
    if linesChanged == false then
        self:InitializeData()
    end
end

function Module:QUEST_ACCEPTED(_, questId)
    self:UpdateQuest(questId, nil, STATUS_IN_PROGRESS)
    self:SendMessage('ChoreTracker_Data_Updated', 'quests')
end

function Module:QUEST_REMOVED(_, questId)
    self:UpdateQuest(questId, nil, STATUS_NOT_STARTED)
    self:SendMessage('ChoreTracker_Data_Updated', 'quests')
end

function Module:QUEST_TURNED_IN(_, questId)
    self:UpdateQuest(questId, nil, STATUS_COMPLETED)
    self:SendMessage('ChoreTracker_Data_Updated', 'quests')
end

function Module:UNIT_QUEST_LOG_CHANGED(targets)
    if targets.player then
        self:ScanQuests()
    end
end

function Module:UpdateSkillLines()
    local skillLines = Addon.db.char.skillLines
    local oldSkillLines = {}
    for key, value in pairs(skillLines) do
        oldSkillLines[key] = value
    end

    wipe(skillLines)

    local professions = { GetProfessions() }
    for i = 1, 5 do
        local professionId = professions[i]
        if professionId ~= nil then
            local _, _, skillLevel, _, _, _, skillLineId, _, _, _, currentSkillLineName = GetProfessionInfo(professionId)
            skillLines[skillLineId] = true

            for _, childSkillLineId in ipairs(Addon.data.professionSkillLines[skillLineId] or {}) do
                local childName = C_TradeSkillUI.GetTradeSkillDisplayName(childSkillLineId)
                if childName == currentSkillLineName then
                    skillLines[childSkillLineId] = skillLevel
                else
                    local childInfo = CTSUI_GetProfessionInfoBySkillLineID(childSkillLineId)
                    if childInfo ~= nil then
                        -- This is only populated after opening a profession window
                        if childInfo.skillLevel > 0 then
                            skillLines[childSkillLineId] = childInfo.skillLevel
                        -- Fall back to checking if the character knows the relevant spell
                        elseif Addon.data.skillLineSpell[childSkillLineId] then
                            if IsSpellKnown(Addon.data.skillLineSpell[childSkillLineId]) then
                                skillLines[childSkillLineId] = oldSkillLines[childSkillLineId] or -1
                            end
                        end
                    end
                end
            end
        end
    end

    local linesChanged = false
    -- Check for unlearned skills
    for key, _ in pairs(oldSkillLines) do
        if skillLines[key] == nil then
            linesChanged = true
            break
        end
    end

    -- Check for learned skills or skill level increases
    for key, value in pairs(skillLines) do
        if oldSkillLines[key] == nil or
            (type(oldSkillLines[key] == 'number') and type(value) == 'number' and oldSkillLines[key] < value)
        then
            linesChanged = true
            break
        end
    end

    if linesChanged then
        self:SendMessage('ChoreTracker_Config_Changed', 'skill lines')
        self:InitializeData()
    end

    return linesChanged
end

function Module:InitializeData()
    wipe(self.autoAccept)
    wipe(self.questPaths)
    wipe(self.scanDungeons)
    wipe(self.scanPois)

    for sectionKey, sectionData in pairs(Addon.data.chores) do
        if sectionData.skillLineId == nil or Addon.db.char.skillLines[sectionData.skillLineId] ~= nil then
            for _, catData in ipairs(sectionData.categories) do
                for _, typeKey in ipairs(DATA_TYPES) do
                    for _, choreData in ipairs(catData[typeKey] or {}) do
                        local choreKey = sectionKey .. '.' .. catData.key .. '.' .. typeKey .. '.' .. choreData.key

                        if choreData.entries ~= nil then
                            local acceptKey = 'autoAccept:' .. sectionKey .. ':' .. catData.key .. ':' .. choreData.key
                            local translation = L[acceptKey]
                            local questIds = nil
                            if translation ~= acceptKey then
                                questIds = {}
                                self.autoAccept[choreKey] = { translation, questIds }
                            end

                            for _, choreEntry in ipairs(choreData.entries) do
                                self.questPaths[choreEntry.quest] = choreKey
                                
                                if questIds ~= nil then
                                    tinsert(questIds, choreEntry.quest)
                                end

                                if choreEntry.actualQuest then
                                    self.questPaths[choreEntry.actualQuest] = choreKey
                                end
                                if choreEntry.unlockQuest then
                                    self.questPaths[choreEntry.unlockQuest] = choreKey
                                end
                            end
                        end

                        if choreData.requiredQuest then
                            self.questPaths[choreData.requiredQuest] = choreKey
                        end

                        if choreData.dungeonId then
                            self.scanDungeons[choreData.dungeonId] = true
                        end
                    end
                end
            end
        end
    end

    for _, sectionData in pairs(Addon.data.delves) do
        for _, mapData in ipairs(sectionData.zones) do
            for _, poi in ipairs(mapData.pois) do
                self.scanPois[poi.active] = mapData.uiMapId
                self.scanPois[poi.inactive] = mapData.uiMapId
                self.questPaths[poi.quest] = true
            end
        end
    end

    self:ScanDungeons()
    self:ScanPois()
    self:ScanQuests(true)
end

function Module:ScanDungeons()
    wipe(self.dungeons)
    for dungeonId, _ in pairs(self.scanDungeons) do
        if IsLFGDungeonJoinable(dungeonId) then
            local doneToday = GetLFGDungeonRewards(dungeonId)
            self.dungeons[dungeonId] = doneToday
        end
    end
end

function Module:GetWeek()
    local weeklyReset = time() + CDAT_GetSecondsUntilWeeklyReset()
    Addon.db.global.questWeeks[weeklyReset] = Addon.db.global.questWeeks[weeklyReset] or {}
    return Addon.db.global.questWeeks[weeklyReset]
end

function Module:ScanPois()
    local anyChanges = false

    for areaPoiId, uiMapId in pairs(self.scanPois) do
        -- { linkedUiMapId, name }
        local poiInfo = CAPI_GetAreaPOIInfo(uiMapId, areaPoiId)
        if poiInfo ~= nil and self.pois[areaPoiId] == nil then
            anyChanges = true
            self.pois[areaPoiId] = poiInfo
        elseif poiInfo == nil and self.pois[areaPoiId] ~= nil then
            anyChanges = true
            self.pois[areaPoiId] = nil
        end
    end

    if anyChanges then
        self:SendMessage('ChoreTracker_Data_Updated', 'pois')
    end
end

function Module:ScanQuests(forceChanged)
    local anyChanges = false
    local week = self:GetWeek()

    for questId, _ in pairs(self.questPaths) do
        local questHadChanges = self:UpdateQuest(questId, week)
        if questHadChanges == true then
            anyChanges = true
        end
    end

    if anyChanges or forceChanged then
        self:SendMessage('ChoreTracker_Data_Updated', 'quests')
    end
end

function Module:UpdateQuest(questId, week, forceStatus)
    if week == nil then
        week = self:GetWeek()
    end

    local oldData = self.quests[questId]
    local newData = {
        status = forceStatus or STATUS_NOT_STARTED,
        accountCompleted = CQL_IsQuestFlaggedCompletedOnAccount(questId),
    }

    if newData.status == STATUS_COMPLETED or CQL_IsQuestFlaggedCompleted(questId) then
        newData.status = STATUS_COMPLETED
    elseif newData.status == STATUS_IN_PROGRESS or
        CQL_IsOnQuest(questId) or
        (CQL_IsWorldQuest(questId) and CTQ_GetQuestTimeLeftSeconds(questId))
    then
        newData.status = STATUS_IN_PROGRESS
        local objectives = CQL_GetQuestObjectives(questId)
        if objectives ~= nil then
            newData.objectives = {}
            for _, objective in ipairs(objectives) do
                if objective ~= nil and (
                    not objective.text or not string.match(objective.text, OPTIONAL_OBJECTIVE)
                ) then
                    local objectiveData = {
                        type = objective.type,
                        text = gsub(
                            objective.text,
                            ":18:18:0:2%|a",
                            ":0:0:0:2|a"
                        ),
                    }

                    if objective.type == 'progressbar' then
                        objectiveData.have = GetQuestProgressBarPercent(questId)
                        objectiveData.need = 100
                    else
                        objectiveData.have = objective.numFulfilled
                        objectiveData.need = objective.numRequired
                    end

                    table.insert(newData.objectives, objectiveData)
                end
            end
        end
    end

    local basicChanged = oldData == nil or oldData.status ~= newData.status

    local objectivesChanged = false
    if basicChanged == false and newData.objectives ~= nil then
        if oldData.objectives == nil then
            objectivesChanged = true
        elseif #oldData.objectives ~= #newData.objectives then
            objectivesChanged = true
        else
            for i = 1, #oldData.objectives do
                local oldObjective = oldData.objectives[i]
                local newObjective = newData.objectives[i]

                if oldObjective.type ~= newObjective.type or
                    oldObjective.text ~= newObjective.text or
                    oldObjective.have ~= newObjective.have or
                    oldObjective.need ~= newObjective.need
                then
                    -- print('objective changed!')
                    objectivesChanged = true
                    break
                end
            end
        end
    end

    local anyChanges = false
    if basicChanged or objectivesChanged then
        anyChanges = true
        self.quests[questId] = newData
        
        -- Store the data for other characters if the quest is at least started
        if newData.status > 0 then
            local weekData = week[questId]
            if weekData == nil or
                (weekData.status == STATUS_COMPLETED and newData.status == STATUS_IN_PROGRESS) or
                (weekData.objectives == nil and newData.objectives ~= nil)
            then
                -- Copy the table in and reset objectives
                weekData = {
                    questId = questId,
                    status = newData.status,
                    objectives = {}
                }

                if newData.objectives ~= nil then
                    self:AddObjectives(weekData, newData)
                end

                week[questId] = weekData
            elseif weekData ~= nil and
                   weekData.status == STATUS_IN_PROGRESS and newData.status == STATUS_IN_PROGRESS and
                   weekData.objectives ~= nil and newData.objectives ~= nil
            then
                weekData.objectives = {}
                self:AddObjectives(weekData, newData)
            end
        end
    end

    return anyChanges
end

function Module:AddObjectives(weekData, newData)
    for _, objective in ipairs(newData.objectives) do
        local text = objective.text
        if text ~= nil then
            text = string.gsub(text, '(%d+)/(%d+)', '0/%2')
        end

        table.insert(weekData.objectives, {
            have = 0,
            need = objective.need,
            text = text,
            type = objective.type,
        })
    end
end
