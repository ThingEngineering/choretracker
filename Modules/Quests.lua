local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Quests')


local CQL_GetQuestObjectives = C_QuestLog.GetQuestObjectives
local CQL_IsOnQuest = C_QuestLog.IsOnQuest
local CQL_IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local DATA_CATEGORIES = {
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

    local profession1, profession2 = GetProfessions()
    if profession1 ~= nil then
        local skillLineId = select(7, GetProfessionInfo(profession1))
        self.skillLines[skillLineId] = true
    end
    if profession2 ~= nil then
        local skillLineId = select(7, GetProfessionInfo(profession2))
        self.skillLines[skillLineId] = true
    end

    for profKey, profData in pairs(Addon.data.professions) do
        if self.skillLines[profData.skillLineId] == true then
            for expKey, expData in pairs(profData.expansions) do
                for _, catKey in ipairs(DATA_CATEGORIES) do
                    for _, questData in ipairs(expData[catKey] or {}) do
                        local questKey = 'professions.' .. profKey .. '.' .. expKey .. '.' .. catKey ..
                            '.' .. questData.key
                        for _, questEntry in ipairs(questData.entries) do
                            self.questPaths[questEntry.quest] = questKey
                        end
                    end
                end
            end
        end
    end
    
    self:ScanQuests()
end

function Module:ScanQuests()
    local anyChanges = false
    for questId, _ in pairs(self.questPaths) do
        local oldData = self.quests[questId]
        local newData = {
            status = STATUS_NOT_STARTED
        }

        if CQL_IsQuestFlaggedCompleted(questId) then
            newData.status = STATUS_COMPLETED
        elseif CQL_IsOnQuest(questId) then
            newData.status = STATUS_IN_PROGRESS
            -- local objectives = CQL_GetQuestObjectives(questId)
            -- if objectives ~= nil then
            --     blah blah blah
            -- end
        end

        if oldData == nil or newData.status ~= oldData.status then
            anyChanges = true
            self.quests[questId] = newData
        end
    end

    if anyChanges then
        print('quests changed')
        self:SendMessage('ChoreTracker_Quests_Updated')
    end
end
