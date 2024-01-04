local addonName, addonTable = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(addonTable, addonName, 'AceConsole-3.0', 'AceEvent-3.0')

Addon:SetDefaultModuleLibraries('AceBucket-3.0', 'AceEvent-3.0')

Addon.data = {
    chores = {},
}
Addon.L = LibStub('AceLocale-3.0'):GetLocale(addonName)

local ADB = LibStub('AceDB-3.0')
local LSM = LibStub('LibSharedMedia-3.0')

local defaultDb = {
    global = {
        questWeeks = {},
    },
    profile = {
        modules = {
            ['**'] = {
                enabled = true,
            }
        },
        general = {
            display = {
                showCompleted = false,
                showCompletedSections = true,
                showObjectives = 'ALL',
                statusIcons = true,
            },
            appearance = {
                backgroundColor = { r = 0, g = 0, b = 0, a = 0.7 },
                borderColor = { r = 63 / 255, g = 63 / 255, b = 63 / 255, a = 0.7 },
                strata = 'LOW',
            },
            text = {
                font = LSM:GetDefault('font'),
                fontSize = 12,
                fontStyle = '',
            }
        },
        window = {
            height = nil,
            width = nil,
            left = nil,
            top = nil,
            locked = false,
            minimized = false,
        },
        desiredShown = true,
        chores = {},
        timers = {},
    }
}


function Addon:OnInitialize()
    for sectionKey, sectionData in pairs(self.data.chores) do
        defaultDb.profile.chores[sectionKey] = {}
        
        for _, catData in ipairs(sectionData.categories or {}) do
            defaultDb.profile.chores[sectionKey][catData.key] = {}

            if catData.drops ~= nil then
                local drops = {}
                for _, dropData in ipairs(catData.drops) do
                    drops[dropData.key] = dropData.defaultEnabled ~= false
                end
                defaultDb.profile.chores[sectionKey][catData.key].drops = drops
            end

            if catData.dungeons ~= nil then
                local dungeons = {}
                for _, dungeonData in ipairs(catData.dungeons) do
                    dungeons[dungeonData.key] = dungeonData.defaultEnabled ~= false
                end
                defaultDb.profile.chores[sectionKey][catData.key].dungeons = dungeons
            end

            if catData.quests ~= nil then
                local quests = {}
                for _, questData in ipairs(catData.quests) do
                    if quests[questData.key] == nil then
                        quests[questData.key] = questData.defaultEnabled ~= false
                    end
                end
                defaultDb.profile.chores[sectionKey][catData.key].quests = quests
            end
        end
    end

    for _, timer in ipairs(self.data.timers) do
        defaultDb.profile.timers[timer.key] = true
    end

    -- DevTools_Dump(defaultDb)

    self:RegisterChatCommand('chores', 'SlashCommand')
    self:RegisterChatCommand('choretracker', 'SlashCommand')

    self.db = ADB:New('ChoreTrackerDB', defaultDb, true) -- default global profile

    -- register events, etc
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function Addon:PLAYER_ENTERING_WORLD()
    for _, module in Addon:IterateModules() do
        if module.OnEnteringWorld ~= nil then
            module:OnEnteringWorld()
        end
    end
end

function Addon:TableKeys(tbl)
    local keys = {}
    for key in pairs(tbl) do
        keys[#keys + 1] = key
    end
    return keys
end

function Addon:SlashCommand(command, editbox)
    if command == 'show' then
        local displayModule = self:GetModule('Display')
        displayModule:SetDesiredShown(true)
    
    elseif command == 'hide' then
        local displayModule = self:GetModule('Display')
        displayModule:SetDesiredShown(false)
    
    elseif command == 'toggle' then
        local displayModule = self:GetModule('Display')
        displayModule:ToggleShown(true)

    elseif command == '' or command == nil then
        local optionsModule = self:GetModule('Options')
        InterfaceOptionsFrame_OpenToCategory(optionsModule.optionsFrame)

    else
        print('ChoreTracker: unknown command')
        print()
        print('  hide: hide the window')
        print('  show: show the window')
        print('  toggle: toggle the window')

    end
end
