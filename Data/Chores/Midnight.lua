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
                    key = 'unity',
                    minimumLevel = 80,
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
            },
        },
    },
}
