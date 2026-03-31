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
                    minimumLevel = 90,
                    requiredEventIds = { 561, 610, 611, 612 }, -- Arena Skirmish Bonus Event
                    entries = {
                        { quest = 93600 }, -- The Arena Calls
                    },
                },
                {
                    key = 'battlegrounds',
                    minimumLevel = 90,
                    requiredEventIds = { 563, 602, 603, 604 }, -- Battleground Bonus Event
                    entries = {
                        { quest = 93593 }, -- A Call to Battle
                    },
                },
                {
                    key = 'preserving',
                    minimumLevel = 90,
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
                    minimumlevel = 90,
                    entries = {
                        { quest = 93423 }, -- Sparks of War: Eversong
                        { quest = 93424 }, -- Sparks of War: Zul'Aman
                        { quest = 93425 }, -- Sparks of War: Harandar
                        { quest = 93426 }, -- Sparks of War: Voidstorm
                    },
                }
            },
        },
        {
            key = 'brawls',
            quests = {
                {
                    key = 'arathiBlizzard',
                    minimumlevel = 90,
                    requiredEventIds = { 666, 673, 680, 697, 737 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'classicAshran',
                    minimumlevel = 90,
                    requiredEventIds = { 1120, 1121, 1122, 1123, 1124 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'compStomp',
                    minimumlevel = 90,
                    requiredEventIds = { 1234, 1235, 1236, 1237, 1238 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'cookingImpossible',
                    minimumlevel = 90,
                    requiredEventIds = { 1047, 1048, 1049, 1050, 1051 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'deepSix',
                    minimumlevel = 90,
                    requiredEventIds = { 702, 704, 705, 706, 736 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'deepwindDunk',
                    minimumlevel = 90,
                    requiredEventIds = { 1239, 1240, 1241, 1242, 1243 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'gravityLapse',
                    minimumlevel = 90,
                    requiredEventIds = { 659, 663, 670, 677, 684 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'packedHouse',
                    minimumlevel = 90,
                    requiredEventIds = { 667, 674, 681, 688, 701 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'shadoPanShowdown',
                    minimumlevel = 90,
                    requiredEventIds = { 1232, 1233, 1244, 1245, 1246, 1312 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'southshoreVsTarrenMill',
                    minimumlevel = 90,
                    requiredEventIds = { 660, 662, 669, 676, 683 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'templeOfHotmogu',
                    minimumlevel = 90,
                    requiredEventIds = { 1166, 1167, 1168, 1169, 1170 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'warsongScramble',
                    minimumlevel = 90,
                    requiredEventIds = { 664, 671, 678, 685, 1221 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
            },
        },
    },
}
