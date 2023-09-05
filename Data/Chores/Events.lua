local _, Addon = ...
local L = Addon.L


Addon.data.choresEvents = {
    key = 'events',
    name = L['section:events'],
    order = 0,
    categories = {
        {
            key = 'holidays',
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
