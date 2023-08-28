local addonName, addonTable = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(addonTable, addonName, 'AceEvent-3.0')

Addon.L = LibStub('AceLocale-3.0'):GetLocale(addonName)
Addon.data = {
    professions = {},
}

Addon:SetDefaultModuleLibraries('AceBucket-3.0', 'AceEvent-3.0')--, 'AceTimer-3.0')

local ADB = LibStub('AceDB-3.0')

-- local ModulePrototype = {
--     UniqueTimer = function(self, name, seconds, callback, ...)
--         self.__timers = self.__timers or {}
        
--         if self.__timers[name] and self:TimeLeft(self.__timers[name]) > 0 then
--             -- print('Timer '..name..' already exists')
--             return
--         end

--         self.__timers[name] = self:ScheduleTimer(callback, seconds, ...)
--     end
-- }
-- Addon:SetDefaultModulePrototype(ModulePrototype)



local defaultDb = {
    profile = {
        modules = {
            ['**'] = {
                enabled = true,
            }
        },
        general = {
            showCompleted = true,
        },
        professions = {},
    }
}


function Addon:OnInitialize()
    for profKey, profData in pairs(self.data.professions) do
        defaultDb.profile.professions[profKey] = {}
        
        for expKey, expData in pairs(profData.expansions) do
            defaultDb.profile.professions[profKey][expKey] = {}

            if #expData.drops > 0 then
                local drops = {}
                for _, dropData in ipairs(expData.drops) do
                    drops[dropData.key] = dropData.defaultEnabled ~= false
                end
                defaultDb.profile.professions[profKey][expKey].drops = drops
            end

            if #expData.quests > 0 then
                local quests = {}
                for _, questData in ipairs(expData.quests) do
                    quests[questData.key] = questData.defaultEnabled ~= false
                end
                defaultDb.profile.professions[profKey][expKey].quests = quests
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
