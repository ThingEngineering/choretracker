local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresPvp = {
    key = 'pvp',
    name = L['section:pvp'],
    order = 50,
    defaultEnabled = false,
    categories = {
        {
            key = 'weekly',
            quests = {
                {
                    key = 'arenaSkirmishes',
                    minimumLevel = 80,
                    requiredEventIds = { 561, 610, 611, 612 }, -- Arena Skirmish Bonus Event
                    entries = {
                        { quest = 83358 }, -- The Arena Calls
                    },
                },
                {
                    key = 'battlegrounds',
                    minimumLevel = 80,
                    requiredEventIds = { 563, 602, 603, 604 }, -- Battleground Bonus Event
                    entries = {
                        { quest = 83345 }, -- A Call to Battle
                    },
                },
                {
                    key = 'preserving',
                    minimumLevel = 80,
                    pick = 2,
                    alwaysShowObjectives = true,
                    entries = {
                        { quest = 80184 }, -- Preserving in Battle
                        { quest = 80185 }, -- Preserving Solo
                        { quest = 80186 }, -- Preserving in War
                        { quest = 80187 }, -- Preserving in Skirmishes
                        { quest = 80188 }, -- Preserving in Arenas
                        { quest = 80189 }, -- Preserving in Teamwork
                    },
                },
                {
                    key = 'sparks',
                    minimumLevel = 70,
                    entries = {
                        { quest=81793 }, -- Sparks of War: Isle of Dorn
                        { quest=81794 }, -- Sparks of War: The Ringing Deeps
                        { quest=81795 }, -- Sparks of War: Hallowfall
                        { quest=81796 }, -- Sparks of War: Azj-Kahet
                    },
                }
            },
        },
        {
            key = 'brawls',
            quests = {
                {
                    key = 'arathiBlizzard',
                    minimumLevel = 80,
                    requiredEventIds = { 666, 673, 680, 697, 737 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'classicAshran',
                    minimumLevel = 80,
                    requiredEventIds = { 1120, 1121, 1122, 1123, 1124 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'compStomp',
                    minimumLevel = 80,
                    requiredEventIds = { 1234, 1235, 1236, 1237, 1238 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'cookingImpossible',
                    minimumLevel = 80,
                    requiredEventIds = { 1047, 1048, 1049, 1050, 1051 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'deepSix',
                    minimumLevel = 80,
                    requiredEventIds = { 702, 704, 705, 706, 736 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'deepwindDunk',
                    minimumLevel = 80,
                    requiredEventIds = { 1239, 1240, 1241, 1242, 1243 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'gravityLapse',
                    minimumLevel = 80,
                    requiredEventIds = { 659, 663, 670, 677, 684 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'packedHouse',
                    minimumLevel = 80,
                    requiredEventIds = { 667, 674, 681, 688, 701 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'shadoPanShowdown',
                    minimumLevel = 80,
                    requiredEventIds = { 1232, 1233, 1244, 1245, 1246, 1312 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'southshoreVsTarrenMill',
                    minimumLevel = 80,
                    requiredEventIds = { 660, 662, 669, 676, 683 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'templeOfHotmogu',
                    minimumLevel = 80,
                    requiredEventIds = { 1166, 1167, 1168, 1169, 1170 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'warsongScramble',
                    minimumLevel = 80,
                    requiredEventIds = { 664, 671, 678, 685, 1221 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
            },
        },
    },
}
