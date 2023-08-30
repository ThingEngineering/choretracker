local addonName, addonTable = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(addonTable, addonName, 'AceEvent-3.0')

Addon.L = LibStub('AceLocale-3.0'):GetLocale(addonName)
Addon.data = {}

Addon:SetDefaultModuleLibraries('AceBucket-3.0', 'AceEvent-3.0')

local ADB = LibStub('AceDB-3.0')

local defaultDb = {
    global = {
        questWeeks = {},
    },
    profile = {
        general = {
            showCompleted = true,
        },
        position = {
            x = 100,
            y = 500,
        },
        sections = {},
        modules = {
            ['**'] = {
                enabled = true,
            }
        },
    }
}


function Addon:OnInitialize()
    for sectionKey, sectionData in pairs(self.data) do
        defaultDb.profile.sections[sectionKey] = {}
        
        for expKey, catData in pairs(sectionData.categories) do
            defaultDb.profile.sections[sectionKey][expKey] = {}

            if catData.drops ~= nil then
                local drops = {}
                for _, dropData in ipairs(catData.drops) do
                    drops[dropData.key] = dropData.defaultEnabled ~= false
                end
                defaultDb.profile.sections[sectionKey][expKey].drops = drops
            end

            if catData.quests ~= nil then
                local quests = {}
                for _, questData in ipairs(catData.quests) do
                    quests[questData.key] = questData.defaultEnabled ~= false
                end
                defaultDb.profile.sections[sectionKey][expKey].quests = quests
            end
        end
    end

    DevTools_Dump(defaultDb)

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
