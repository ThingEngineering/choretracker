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
                    key = 'hope',
                    minimumLevel = 80,
                    filter = function()
                        return UnitLevel('player') < 90
                    end,
                    entries = {
                        { quest = 95468 }, -- Hope in the Darkest Corners
                    },
                },
                {
                    key = 'unity',
                    minimumLevel = 90,
                    entries = {
                        { quest = 93890 }, -- Midnight: Abundance
                        { quest = 93767 }, -- Midnight: Arcantina
                        { quest = 94457 }, -- Midnight: Battlegrounds
                        { quest = 93909 }, -- Midnight: Delves
                        { quest = 93911 }, -- Midnight: Dungeons
                        { quest = 93769 }, -- Midnight: Housing
                        { quest = 93891 }, -- Midnight: Legends of the Haranir
                        { quest = 93910 }, -- Midnight: Prey
                        { quest = 93912 }, -- Midnight: Raid
                        { quest = 93889 }, -- Midnight: Saltheril's Soiree
                        { quest = 93892 }, -- Midnight: Stormarion Assault
                        { quest = 93913 }, -- Midnight: World Boss
                        { quest = 93766 }, -- Midnight: World Quests
                    },
                },
                {
                    key = 'abundance',
                    minimumLevel = 80,
                    entries = {
                        { quest = 89507 }, -- Abundant Offerings
                    },
                },
                {
                    key = 'legends',
                    minimumLevel = 80,
                    entries = {
                        -- 89268 Lost Legends
                        { quest = 88993, unlockQuest = 89268 }, -- Wey'nan's Ward
                        { quest = 88994, unlockQuest = 89268 }, -- The Cauldron of Echoes
                        { quest = 88995, unlockQuest = 89268 }, -- Aln'hara's Bloom
                        { quest = 88996, unlockQuest = 89268 }, -- The Echoless Flame
                        { quest = 88997, unlockQuest = 89268 }, -- Russula's Outreach
                        { quest = 90733, unlockQuest = 89268 }, -- The Listener
                        { quest = 90734, unlockQuest = 89268 }, -- In the Name of the Goddess
                    },
                },
                {
                    key = 'soireeInvite',
                    minimumLevel = 80,
                    oncePerAccount = true,
                    entries = {
                        { quest = 89289 }, -- Favor of the Court
                    }
                },
                {
                    key = 'soiree',
                    minimumLevel = 80,
                    requiredQuest = 89290,
                    entries = {
                        { quest = 90573 }, -- Fortify the Runestones: Magisters
                        { quest = 90574 }, -- Fortify the Runestones: Blood Knights
                        { quest = 90575 }, -- Fortify the Runestones: Farstriders
                        { quest = 90576 }, -- Fortify the Runestones: Shades of the Row                        { quest = 89507 }, -- Abundant Offerings
                    },
                },
                {
                    key = 'stormarion',
                    minimumLevel = 80,
                    entries = {
                        { quest = 90962 }, -- Stormarion Assault
                    },
                },
                {
                    key = 'specialAssignment',
                    minimumLevel = 80,
                    pick = 2,
                    alwaysShowObjectives = true,
                    removeText = L['remove_specialAssignment'],
                    entries = {
                        { quest = 91390, unlockQuest = 94865 }, -- Special Assignment: What Remains of a Temple Broken
                        { quest = 91796, unlockQuest = 94866 }, -- Special Assignment: Ours Once More!
                        { quest = 92063, unlockQuest = 94390 }, -- Special Assignment: A Hunter's Regret
                        { quest = 92139, unlockQuest = 95435 }, -- Special Assignment: Shade and Claw
                        { quest = 92145, unlockQuest = 92848 }, -- Special Assignment: The Grand Magister's Drink
                        { quest = 93013, unlockQuest = 94391 }, -- Special Assignment: Push Back the Light
                        { quest = 93244, unlockQuest = 94795 }, -- Special Assignment: Agents of the Shield
                        { quest = 93438, unlockQuest = 94743 }, -- Special Assignment: Precision Excision
                    },
                },
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
                {
                    key = 'worldBoss',
                    minimumLevel = 90,
                    alwaysQuestName = true,
                    entries = {
                        { quest = 92123 }, -- Cragpine
                        { quest = 92560 }, -- Lu'ashal
                        { quest = 92636 }, -- Predaxas
                        { quest = 92034 }, -- Thorm'belan
                    },
                },
                {
                    key = 'worldBossFirst',
                    minimumLevel = 90,
                    alwaysQuestName = true,
                    oncePerAccount = true,
                    entries = {
                        { quest = 92127 }, -- Cragpine
                        { quest = 92128 }, -- Lu'ashal
                        { quest = 92129 }, -- Predaxas
                        { quest = 92130 }, -- Thorm'belan
                    },
                },
            },
        },
    },
}
