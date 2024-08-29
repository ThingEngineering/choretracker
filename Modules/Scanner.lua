local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule(
    'Scanner',
    {
        dungeons = {},
        quests = {},
        questPaths = {},
        scanDungeons = {},
    }
)


local CDAT_GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset
local CQL_GetQuestObjectives = C_QuestLog.GetQuestObjectives
local CQL_IsOnQuest = C_QuestLog.IsOnQuest
local CQL_IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local CTSUI_GetProfessionInfoBySkillLineID = C_TradeSkillUI.GetProfessionInfoBySkillLineID

local DATA_TYPES = {
    'drops',
    'dungeons',
    'quests',
}
local STATUS_NOT_STARTED = 0
local STATUS_IN_PROGRESS = 1
local STATUS_COMPLETED = 2
local PROFESSION_SKILL_LINES = {
    -- Alchemy
    [171] = {
        2823, -- Dragon Isles
        2871, -- Khaz Algar
    },
    -- Blacksmithing
    [164] = {
        2822, -- Dragon Isles
        2872, -- Khaz Algar
    },
    -- Enchanting
    [333] = {
        2825, -- Dragon Isles
        2874, -- Khaz Algar
    },
    -- Engineering
    [202] = {
        2827, -- Dragon Isles
        2875, -- Khaz Algar
    },
    -- Herbalism
    [182] = {
        2832, -- Dragon Isles
        2877, -- Khaz Algar
    },
    -- Inscription
    [773] = {
        2828, -- Dragon Isles
        2878, -- Khaz Algar
    },
    -- Jewelcrafting
    [755] = {
        2829, -- Dragon Isles
        2879, -- Khaz Algar
    },
    -- Leatherworking
    [165] = {
        2830, -- Dragon Isles
        2880, -- Khaz Algar
    },
    -- Mining
    [186] = {
        2833, -- Dragon Isles
        2881, -- Khaz Algar
    },
    -- Skinning
    [393] = {
        2834, -- Dragon Isles
        2882, -- Khaz Algar
    },
    -- Tailoring
    [197] = {
        2831, -- Dragon Isles
        2883, -- Khaz Algar
    },
}

function Module:OnEnable()
    self:RegisterEvent('QUEST_ACCEPTED')
    self:RegisterEvent('QUEST_REMOVED')
    self:RegisterEvent('QUEST_TURNED_IN')

    self:RegisterBucketEvent(
        {
            'TRADE_SKILL_SHOW',
        },
        1,
        'UpdateSkillLines'
    )
    self:RegisterBucketEvent(
        {
            'ENCOUNTER_LOOT_RECEIVED',
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
    self:InitializeData()
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
    local oldSkillLines = {}
    for key, value in pairs(Addon.db.char.skillLines) do
        oldSkillLines[key] = value
    end

    wipe(self.questPaths)
    wipe(self.scanDungeons)
    wipe(Addon.db.char.skillLines)

    local professions = { GetProfessions() }
    for i = 1, 5 do
        local professionId = professions[i]
        if professionId ~= nil then
            local _, _, _, _, _, _, skillLineId = GetProfessionInfo(professionId)
            Addon.db.char.skillLines[skillLineId] = true

            for _, childSkillLineId in ipairs(PROFESSION_SKILL_LINES[skillLineId] or {}) do
                local childInfo = CTSUI_GetProfessionInfoBySkillLineID(childSkillLineId)
                if childInfo ~= nil and childInfo.skillLevel > 0 then
                    Addon.db.char.skillLines[childSkillLineId] = childInfo.skillLevel
                end
            end
        end
    end

    local linesChanged = false
    -- Check for unlearned skills
    for key, _ in pairs(oldSkillLines) do
        if Addon.db.char.skillLines[key] == nil then
            linesChanged = true
            break
        end
    end

    -- Check for learned skills or skill level increases
    for key, value in pairs(Addon.db.char.skillLines) do
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
end

function Module:InitializeData()
    for sectionKey, sectionData in pairs(Addon.data.chores) do
        if sectionData.skillLineId == nil or Addon.db.char.skillLines[sectionData.skillLineId] ~= nil then
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

function Module:GetWeek()
    local weeklyReset = time() + CDAT_GetSecondsUntilWeeklyReset()
    Addon.db.global.questWeeks[weeklyReset] = Addon.db.global.questWeeks[weeklyReset] or {}
    return Addon.db.global.questWeeks[weeklyReset]
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
    }

    if newData.status == STATUS_COMPLETED or CQL_IsQuestFlaggedCompleted(questId) then
        newData.status = STATUS_COMPLETED
    elseif newData.status == STATUS_IN_PROGRESS or CQL_IsOnQuest(questId) then
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
