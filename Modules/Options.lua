local Addon = LibStub('AceAddon-3.0'):GetAddon('ChoreTracker')
local Module = Addon:NewModule('Options')

local AC = LibStub('AceConfig-3.0')
local ACD = LibStub('AceConfigDialog-3.0')

local options = {
    type = 'group',
    name = 'ChoreTracker',
    get = function(c)
        print(c)
        return Addon.db.profile[c]
    end,
    args = {

    }
}

function Module:OnInitialize()
    AC:RegisterOptionsTable('ChoreTracker', options)
    self.optionsFrame = ACD:AddToBlizOptions('ChoreTracker', 'ChoreTracker')
end
