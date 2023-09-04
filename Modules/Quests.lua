local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Quests')


local CDAT_GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset
local CQL_GetQuestObjectives = C_QuestLog.GetQuestObjectives
local CQL_IsOnQuest = C_QuestLog.IsOnQuest
local CQL_IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local DATA_TYPES = {
    'drops',
    'quests',
}
local STATUS_NOT_STARTED = 0
local STATUS_IN_PROGRESS = 1
local STATUS_COMPLETED = 2

function Module:OnEnable()
    self.quests = {}
    self:InitializeQuests()

    self:RegisterBucketEvent(
        {
            'SKILL_LINES_CHANGED',
        },
        1,
        'InitializeQuests'
    )
    self:RegisterBucketEvent(
        {
            'QUEST_LOG_UPDATE', -- spammy quest log updates
        },
        1,
        'ScanQuests'
    )
end

function Module:InitializeQuests()
    self.questPaths = {}
    self.skillLines = {}

    local professions = { GetProfessions() }
    for _, professionId in ipairs(professions) do
        if professionId ~= nil then
            local skillLineId = select(7, GetProfessionInfo(professionId))
            self.skillLines[skillLineId] = true
        end
    end

    for sectionKey, sectionData in pairs(Addon.data) do
        if sectionData.skillLineId == nil or self.skillLines[sectionData.skillLineId] == true then
            for _, catData in ipairs(sectionData.categories) do
                for _, typeKey in ipairs(DATA_TYPES) do
                    for _, questData in ipairs(catData[typeKey] or {}) do
                        local questKey = sectionKey .. '.' .. catData.key .. '.' .. typeKey .. '.' .. questData.key
                        
                        for _, questEntry in ipairs(questData.entries) do
                            self.questPaths[questEntry.quest] = questKey
                        end

                        if questData.requiredQuest then
                            self.questPaths[questData.requiredQuest] = questKey
                        end
                    end
                end
            end
        end
    end
    
    self:ScanQuests()
end

function Module:ScanQuests()
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
                            text = objective.text,
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

    if anyChanges then
        -- print('quests changed')
        self:SendMessage('ChoreTracker_Quests_Updated')
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
