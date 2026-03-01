local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresMidnight = {
    key = 'midnight',
    name = EXPANSION_NAME11,
    order = 20,
    minimumLevel = 80,
    categories = {
        {
            key = 'patch_12_0_0',
            quests = {
                {
                    key = 'dungeon',
                    minimumLevel = 90,
                    alwaysQuestName = true,
                    oncePerAccount = true, -- rewards suck
                    entries = {
                        { quest = 93751 }, -- Windrunner Spire
                        { quest = 93752 }, -- Murder Row
                        { quest = 93753 }, -- Magisters' Terrace
                        { quest = 93754 }, -- Maisara Caverns
                        { quest = 93755 }, -- Den of Nalorakk
                        { quest = 93756 }, -- The Blinding Vale
                        { quest = 93757 }, -- Voidscar Arena
                        { quest = 93758 }, -- Nexus-Point Xenas
                    },
                },
            },
        },
    },
}
