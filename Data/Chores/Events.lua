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
                    requiredEventIds = { 1335, 1352, 1353, 1354 }, -- Dragonflight Dungeon Event
                    entries = {
                        { quest=72722, item=207030, level=70 }, -- Emissary of War
                    },
                },
            },
        },
    },
}
