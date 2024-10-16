local addonName, Addon = ...
local L = Addon.L

local MODE_IDLE = 0
local MODE_SCAN = 1
local MODE_ACCEPT = 2

local Module = Addon:NewModule(
    'AutoAccept',
    {
        mode = MODE_IDLE,
        accepting = nil,
        offset = 0,
        scans = 0,
        tryAccepting = {},
    },
    'AceHook-3.0'
)

local ScannerModule

local CAJ_GetSuggestions = C_AdventureJournal.GetSuggestions
local CAJ_UpdateSuggestions = C_AdventureJournal.UpdateSuggestions


function Module:OnEnable()
    ScannerModule = Addon:GetModule('Scanner')

    self:RegisterEvent('AJ_REFRESH_DISPLAY')
    self:RegisterEvent('QUEST_ACCEPTED')
    self:RegisterEvent('QUEST_DETAIL')
end

function Module:OnEnteringWorld()
    C_Timer.After(0, function() self:ScanJournal() end)
end

function Module:AJ_REFRESH_DISPLAY()
    if self.mode ~= MODE_SCAN then return end

    local suggestions = CAJ_GetSuggestions()
    if suggestions == nil then
        -- print('no suggestions??')
        return
    end

    local currentOffset = C_AdventureJournal.GetPrimaryOffset()
    if currentOffset ~= self.offset then
        -- print('offset '..currentOffset..' != '..self.offset)
        C_AdventureJournal.SetPrimaryOffset(self.offset)
        return
    end

    local max = currentOffset == 0 and #suggestions or 1
    for i = 1, max do
        local shouldAccept = self:CheckSuggestion(suggestions[i], currentOffset, i)
        if shouldAccept then
            self.mode = MODE_ACCEPT
            C_AdventureJournal.ActivateEntry(i)
            return
        end
    end

    local numSuggestions = C_AdventureJournal.GetNumAvailableSuggestions()
    if (currentOffset + 1) < numSuggestions then
        self.offset = self.offset + 1
        C_Timer.After(0, function() C_AdventureJournal.SetPrimaryOffset(self.offset) end)
    else
        self.mode = MODE_IDLE
        self.scans = 0
        C_Timer.After(0, function() C_AdventureJournal.SetPrimaryOffset(0) end)
    end
end

function Module:QUEST_ACCEPTED(_, questId)
    if questId == self.accepting then
        self.accepting = nil
        -- restart the scan
        self.mode = MODE_SCAN

        C_Timer.After(1, function() self:AJ_REFRESH_DISPLAY() end)
    end
end

function Module:QUEST_DETAIL()
    local questId = GetQuestID()
    -- print('QUEST_DETAIL '..questId)
    if self.tryAccepting[questId] == true then
        self.tryAccepting[questId] = nil
        self.accepting = questId

        if QuestGetAutoAccept() then
            CloseQuest()
        else
            AcceptQuest()
        end

        -- Give up after 1s waiting for the quest to accept
        C_Timer.After(1, function()
            if self.mode == MODE_ACCEPT and self.accepting == questId then
                self:ScanJournal()
            end
        end)
    end
end

function Module:CheckSuggestion(suggestion, offset, index)
    -- print(offset, index, suggestion.title)
    local acceptQuest = L['autoAccept:acceptQuest']
    local startQuest = L['autoAccept:startQuest']

    for choreKey, acceptData in pairs(ScannerModule.autoAccept) do
        local parts = { strsplit('.', choreKey) }
        local enabled = Addon.db.profile.chores[parts[1]][parts[2]][parts[3]][parts[4]]
        if enabled == true then
            local matchString, questIds = unpack(acceptData)
            if (suggestion.buttonText == acceptQuest or
                suggestion.buttonText == startQuest) and
                (strmatch(suggestion.title, matchString) or
                strmatch(suggestion.description, matchString))
            then
                local start = true
                for _, questId in ipairs(questIds) do
                    local questStatus = ScannerModule.quests[questId]
                    if questStatus ~= nil and questStatus.status > 0 then
                        start = false
                        break
                    end
                end

                if start then
                    -- print('accept '..offset..' '..index..' '..suggestion.title)
                    for _, questId in ipairs(questIds) do
                        self.tryAccepting[questId] = true
                    end
                    return true
                end

                return false
            end
        end
    end

    return false
end

function Module:ScanJournal()
    if not Addon.db.profile.general.automation.acceptQuests then return end

    self.scans = self.scans + 1

    if self.scans > 20 then
        print('ChoreTracker: more than 20 scans??')
        self.scans = 0
        return
    end

    self.mode = MODE_SCAN
    self.accepting = nil
    self.offset = 0
    wipe(self.tryAccepting)

    CAJ_UpdateSuggestions(false)
end
