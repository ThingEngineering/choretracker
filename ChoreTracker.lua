local Addon = LibStub('AceAddon-3.0'):NewAddon('ChoreTracker', 'AceEvent-3.0')
Addon:SetDefaultModuleLibraries('AceBucket-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

local ModulePrototype = {
    UniqueTimer = function(self, name, seconds, callback, ...)
        self.__timers = self.__timers or {}
        
        if self.__timers[name] and self:TimeLeft(self.__timers[name]) > 0 then
            -- print('Timer '..name..' already exists')
            return
        end

        self.__timers[name] = self:ScheduleTimer(callback, seconds, ...)
    end
}
Addon:SetDefaultModulePrototype(ModulePrototype)


local defaultDb = {
    profile = {
        modules = {
            ['**'] = {
                enabled = true,
            }
        }
    }
}


function Addon:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('ChoreTrackerDB', defaultDb, true) -- default global profile

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
