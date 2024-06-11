local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresRemixPandaria = {
    key = 'remixPandaria',
    name = 'Remix: Pandaria',
    order = 100,
    minimumLevel = 60,
    filter = function()
        -- yes Remix: Pandaria aura
        return C_UnitAuras.GetPlayerAuraBySpellID(424143) ~= nil
    end,
    categories = {
        {
            key = 'dailies',
            quests = {
                {
                    key = 'scenario',
                    minimumLevel = 10,
                    entries = {
                        { quest = 80448 }, -- A Fresh Scene
                    },
                },
                {
                    key = 'dungeon',
                    minimumLevel = 10,
                    entries = {
                        { quest = 80446 }, -- Last Hurrah: Dragon Isles
                    },
                },
                {
                    key = 'raid',
                    minimumLevel = 25,
                    entries = {
                        { quest = 80447 }, -- Last Hurrah: Dragon Isles
                    },
                },
            },
        },
        {
            key = 'worldBosses',
            quests = {
                {
                    key = 'galleon',
                    minimumLevel = 10,
                    entries = {
                        { quest = 32098 },
                    },
                },
                {
                    key = 'sha',
                    minimumLevel = 10,
                    entries = {
                        { quest = 32099 },
                    },
                },
                {
                    key = 'nalak',
                    minimumLevel = 10,
                    entries = {
                        { quest = 32518 },
                    },
                },
                {
                    key = 'oondasta',
                    minimumLevel = 10,
                    entries = {
                        { quest = 32519 },
                    },
                },
                {
                    key = 'celestials',
                    minimumLevel = 10,
                    entries = {
                        { quest = 33117 },
                    },
                },
                {
                    key = 'ordos',
                    minimumLevel = 10,
                    entries = {
                        { quest = 33118 },
                    },
                },
            },
        },
    },
}
