local _, Addon = ...
local L = Addon.L


Addon.data.events = {
    key = 'events',
    name = L['dragonflight_chores'],
    order = 0,
    categories = {
        {
            key = 'holiays',
            quests = {
                {
                    key = 'mythicDungeons',
                    entries = {
                        { quest=72722, item=207030, level=70 }, -- Emissary of War
                    }
                }
            },
        },
    },
}
