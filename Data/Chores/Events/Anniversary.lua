local _, Addon = ...
local L = Addon.L


local anniversaryIds = { 590, 1500, 1501, 1509, 1587, 1588, 1589, 1590, 1592, 1593, 1594, 1595 }


Addon.data.chores.choresAnniversary = {
    key = 'anniversary',
    name = L['section:anniversary'],
    order = 0,
    categories = {
        {
            key = 'anniversary',
            quests = {
                {
                    key = 'celebrate',
                    requiredEventIds = anniversaryIds,
                    alwaysShowObjectives = true,
                    dailyQuest = true,
                    entries = {
                        { quest = 84616 }, -- Celebrate Good Fun!
                    },
                },
                {
                    key = 'reflect',
                    requiredEventIds = anniversaryIds,
                    dailyQuest = true,
                    entries = {
                        { quest = 43461 }, -- A Time to Reflect
                    },
                },
                {
                    key = 'meetGreet',
                    requiredEventIds = anniversaryIds,
                    oncePerAccount = true,
                    entries = {
                        { quest = 84254 }, -- Meet and Greet
                    },
                },
                {
                    key = 'shopping',
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 84489 }, -- Shopping Squee!
                    },
                },
                {
                    key = 'truth',
                    requiredEventIds = anniversaryIds,
                    oncePerAccount = true,
                    entries = {
                        { quest = 84735 }, -- Truth of the Dark Irons
                    },
                },
                {
                    key = 'chromieCodex',
                    minimumLevel = 10,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 82783 }, -- Chromie's Codex
                    },
                },
                {
                    key = 'soldier',
                    minimumLevel = 10,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 57300 }, -- Soldier of Time
                    },
                },
                {
                    key = 'originals',
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 47253 }, -- The Originals [A]
                        { quest = 47254 }, -- The Originals [H]
                    },
                },
                {
                    key = 'timely',
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 60215 }, -- Timely Gate Crashers
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
                    key = 'doomwalkerKill',
                    minimumLevel = 15,
                    noText = true,
                    requiredEventIds = anniversaryIds,
                    entries = {
                        { quest = 60214 },
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
