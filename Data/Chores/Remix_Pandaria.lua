local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresRemixPandaria = {
    key = 'remixPandaria',
    name = 'Remix: Pandaria',
    order = 100,
    minimumLevel = 10,
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
                        { quest = 80446 }, -- Looking for Group
                    },
                },
                {
                    key = 'raid',
                    minimumLevel = 25,
                    entries = {
                        { quest = 80447 }, -- Looking for More
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
                        { quest = 32098, encounter = { 725, 1 } },
                    },
                },
                {
                    key = 'sha',
                    minimumLevel = 10,
                    entries = {
                        { quest = 32099, encounter = { 691, 1 } },
                    },
                },
                {
                    key = 'nalak',
                    minimumLevel = 10,
                    entries = {
                        { quest = 32518, encounter = { 814, 1 } },
                    },
                },
                {
                    key = 'oondasta',
                    minimumLevel = 10,
                    entries = {
                        { quest = 32519, encounter = { 826, 1 } },
                    },
                },
                {
                    key = 'celestials',
                    minimumLevel = 10,
                    entries = {
                        { quest = 33117, encounter = { 858, 1 } },
                    },
                },
                {
                    key = 'ordos',
                    minimumLevel = 10,
                    entries = {
                        { quest = 33118, encounter = { 861, 1 } },
                    },
                },
            },
        },
    },
}
