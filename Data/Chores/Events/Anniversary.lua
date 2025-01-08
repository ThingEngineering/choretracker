local _, Addon = ...
local L = Addon.L


local anniversaryIds = { 590, 1500, 1501, 1509, 1587, 1588, 1589, 1590, 1592, 1593, 1594, 1595 }

local CUA_GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID

Addon.data.chores.choresAnniversary = {
    key = 'anniversary',
    name = L['section:anniversary'],
    order = 0,
    categories = {
        {
            key = 'anniversary',
            quests = {
                {
                    key = 'reflect',
                    dailyQuest = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 43323 }, -- A Time to Reflect [A]
                        { quest = 43461 }, -- A Time to Reflect [H]
                    },
                },
                {
                    key = 'celebrate',
                    dailyQuest = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 84616 }, -- Celebrate Good Fun!
                    },
                    filter = function()
                        return CUA_GetPlayerAuraBySpellID(455050) == nil
                    end,
                },
                {
                    key = 'meetGreet',
                    anniversaryAccount = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 84254 }, -- Meet and Greet
                    },
                },
                {
                    key = 'shopping',
                    anniversaryAccount = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 84489 }, -- Shopping Squee!
                    },
                },
                {
                    key = 'truth',
                    anniversaryAccount = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 84735 }, -- Truth of the Dark Irons
                    },
                },
                {
                    key = 'chromieCodex',
                    minimumLevel = 10,
                    anniversaryAccount = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 82783 }, -- Chromie's Codex
                    },
                },
                {
                    key = 'soldier',
                    minimumLevel = 10,
                    anniversaryAccount = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 57300 }, -- Soldier of Time
                    },
                },
                {
                    key = 'timely',
                    anniversaryAccount = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 47253 }, -- The Originals [A]
                        { quest = 47254 }, -- The Originals [H]
                        { quest = 60215, lockoutQuest = 84606 }, -- Timely Gate Crashers
                    },
                },
                {
                    key = 'archavonKill',
                    minimumLevel = 15,
                    noText = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 84256 },
                    },
                },
                {
                    key = 'doomwalkerKill',
                    minimumLevel = 15,
                    noText = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 60214 },
                    },
                },
                {
                    key = 'shaOfAngerKill',
                    minimumLevel = 15,
                    noText = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 84282 },
                    },
                },
                {
                    key = 'azuregosKill',
                    minimumLevel = 15,
                    noText = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 47462 },
                    },
                },
                {
                    key = 'dragonsOfNightmareKill',
                    minimumLevel = 15,
                    noText = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 47463 },
                    },
                },
                {
                    key = 'lordKazzakKill',
                    minimumLevel = 15,
                    noText = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 47461 },
                    },
                },
            },
        },
    },
}
