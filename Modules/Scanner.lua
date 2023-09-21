local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Scanner')


local CDAT_GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset
local CQL_GetQuestObjectives = C_QuestLog.GetQuestObjectives
local CQL_IsOnQuest = C_QuestLog.IsOnQuest
local CQL_IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local DATA_TYPES = {
    'drops',
    'dungeons',
    'quests',
}
local STATUS_NOT_STARTED = 0
local STATUS_IN_PROGRESS = 1
local STATUS_COMPLETED = 2
local PROFESSION_DRAGONFLIGHT = {
    [171] = 2823, -- Alchemy
    [164] = 2822, -- Blacksmithing
    [333] = 2825, -- Enchanting
    [202] = 2827, -- Engineering
    [182] = 2832, -- Herbalism
    [773] = 2828, -- Inscription
    [755] = 2829, -- Jewelcrafting
    [165] = 2830, -- Leatherworking
    [186] = 2833, -- Mining
    [393] = 2834, -- Skinning
    [197] = 2831, -- Tailoring
}

function Module:OnEnable()
    self.dungeons = {}
    self.quests = {}
    self.questPaths = {}
    self.scanDungeons = {}
    self.skillLines = {}

    self:RegisterBucketEvent(
        {
            'SKILL_LINES_CHANGED',
            'TRADE_SKILL_LIST_UPDATE',
        },
        1,
        'InitializeData'
    )
    self:RegisterBucketEvent(
        {
            'QUEST_LOG_UPDATE', -- spammy quest log updates
        },
        1,
        'ScanQuests'
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
    self:InitializeData()
end

function Module:InitializeData()
    local oldSkillLines = {}
    for key, value in pairs(self.skillLines) do
        oldSkillLines[key] = value
    end

    wipe(self.questPaths)
    wipe(self.scanDungeons)
    wipe(self.skillLines)

    local professions = { GetProfessions() }
    for i = 1, 5 do
        local professionId = professions[i]
        if professionId ~= nil then
            local _, _, skillLevel, _, _, _, skillLineId, _, _, _, subName = GetProfessionInfo(professionId)
            self.skillLines[skillLineId] = true

            local dfId = PROFESSION_DRAGONFLIGHT[skillLineId]
            if dfId ~= nil then
                local expectedName = C_TradeSkillUI.GetTradeSkillDisplayName(dfId)
                if expectedName == subName then
                    self.skillLines[dfId] = skillLevel
                end
            end
        end
    end

    local linesChanged = false
    -- Check for unlearned skills
    for key, _ in pairs(oldSkillLines) do
        if self.skillLines[key] == nil then
            linesChanged = true
            break
        end
    end

    -- Check for learned skills or skill level increases
    for key, value in pairs(self.skillLines) do
        if oldSkillLines[key] == nil or
            (type(oldSkillLines[key] == 'number') and type(value) == 'number' and oldSkillLines[key] < value)
        then
            linesChanged = true
            break
        end
    end

    if linesChanged then
        self:SendMessage('ChoreTracker_Config_Changed', 'skill lines')
    end

    for sectionKey, sectionData in pairs(Addon.data.chores) do
        if sectionData.skillLineId == nil or self.skillLines[sectionData.skillLineId] ~= nil then
            for _, catData in ipairs(sectionData.categories) do
                for _, typeKey in ipairs(DATA_TYPES) do
                    for _, choreData in ipairs(catData[typeKey] or {}) do
                        local choreKey = sectionKey .. '.' .. catData.key .. '.' .. typeKey .. '.' .. choreData.key
                        
                        if choreData.entries ~= nil then
                            for _, choreEntry in ipairs(choreData.entries) do
                                self.questPaths[choreEntry.quest] = choreKey
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
    
    self:ScanDungeons()
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

function Module:ScanQuests(forceChanged)
    local weeklyReset = time() + CDAT_GetSecondsUntilWeeklyReset()
    Addon.db.global.questWeeks[weeklyReset] = Addon.db.global.questWeeks[weeklyReset] or {}
    local week = Addon.db.global.questWeeks[weeklyReset]

    local anyChanges = false
    for questId, _ in pairs(self.questPaths) do
        local oldData = self.quests[questId]
        local newData = {
            status = STATUS_NOT_STARTED,
        }

        if CQL_IsQuestFlaggedCompleted(questId) then
            newData.status = STATUS_COMPLETED
        elseif CQL_IsOnQuest(questId) then
            newData.status = STATUS_IN_PROGRESS
            local objectives = CQL_GetQuestObjectives(questId)
            if objectives ~= nil then
                newData.objectives = {}
                for _, objective in ipairs(objectives) do
                    if objective ~= nil then
                        local objectiveData = {
                            type = objective.type,
                            text = gsub(
                                objective.text,
                                ":18:18:0:2%|a",
                                ":0:0:0:2|a"
                            ),objective.text,
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
    end

    if anyChanges or forceChanged then
        self:SendMessage('ChoreTracker_Data_Updated', 'quests')
    end
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
