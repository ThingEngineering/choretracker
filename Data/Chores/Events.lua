local _, Addon = ...
local L = Addon.L


local tbcTimewalkingIds = { 559, 622, 623, 624 }
local wotlkTimewalkingIds = { 562, 616, 617, 618 }
local cataTimewalkingIds = { 587, 628, 629, 630 }
local mopTimewalkingIds = { 643, 652, 654, 656 }
local wodTimewalkingIds = { 1056, 1063, 1065, 1068 }
local legionTimewalkingIds = { 1263, 1265, 1267, 1269, 1271, 1273, 1275, 1277 }

Addon.data.chores.choresEvents = {
    key = 'events',
    name = L['section:events'],
    order = 0,
    categories = {
        {
            key = 'holidays2',
            dungeons = {
                {
                    key = 'crownChemicalCo',
                    minimumLevel = 60,
                    requiredEventIds = { 335, 423 },
                    dungeonId = 288,
                },
                {
                    key = 'corenDirebrew',
                    minimumLevel = 60,
                    requiredEventIds = { 372 },
                    dungeonId = 287,
                },
                {
                    key = 'headlessHorseman',
                    minimumLevel = 60,
                    requiredEventIds = { 324, 1405 },
                    dungeonId = 285,
                },
                {
                    key = 'frostLordAhune',
                    minimumLevel = 60,
                    requiredEventIds = { 141 },
                    dungeonId = 286,
                },
            },
        },
        {
            key = 'holidays',
            quests = {
                {
                    key = 'arenaSkirmishes',
                    minimumLevel = 70,
                    requiredEventIds = { 238 }, -- Arena Skirmish Bonus Event
                    entries = {
                        { quest = 72720 }, -- The Arena Calls
                    },
                },
                {
                    key = 'battlegrounds',
                    minimumLevel = 70,
                    requiredEventIds = { 236 }, -- Battleground Bonus Event
                    entries = {
                        { quest = 72723 }, -- A Call to Battle
                    },
                },
                {
                    key = 'mythicDungeons',
                    minimumLevel = 70,
                    requiredEventIds = { 1335, 1352, 1353, 1354 }, -- Dragonflight Dungeon Event
                    entries = {
                        { quest = 72722 }, -- Emissary of War
                    },
                },
                {
                    key = 'pvpPetBattles',
                    minimumLevel = 70,
                    requiredEventIds = { 234 }, -- Pet Battle Bonus Event
                    entries = {
                        { quest = 72721 }, -- The Very Best
                    },
                },

                -- TBC
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 70,
                    requiredEventIds = tbcTimewalkingIds,
                    entries = {
                        { quest = 72727 }, -- A Burning Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = tbcTimewalkingIds,
                    entries = {
                        { quest = 40168, item = 129747 }, -- [TBC] The Swirling Vial
                    },
                },
                -- WotLK
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 70,
                    requiredEventIds = wotlkTimewalkingIds,
                    entries = {
                        { quest = 72726 }, -- A Frozen Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = wotlkTimewalkingIds,
                    entries = {
                        { quest = 40173, item = 129928 }, -- [WotLK] The Unstable Prism
                    },
                },
                -- Cata
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 70,
                    requiredEventIds = cataTimewalkingIds,
                    entries = {
                        { quest = 72810 }, -- A Shattered Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 35,
                    requiredEventIds = cataTimewalkingIds,
                    entries = {
                        { quest = 40786, item = 133377 }, -- [Cata-H] The Smoldering Ember
                        { quest = 40787, item = 133378 }, -- [Cata-A] The Smoldering Ember
                    },
                },
                -- MoP
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 70,
                    requiredEventIds = mopTimewalkingIds,
                    entries = {
                        { quest = 72725 }, -- A Shrouded Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 35,
                    requiredEventIds = mopTimewalkingIds,
                    entries = {
                        { quest = 45563, item = 143776 }, -- [MoP] The Shrouded Coin
                    },
                },
                -- WoD
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 70,
                    requiredEventIds = wodTimewalkingIds,
                    entries = {
                        { quest = 72724 }, -- A Savage Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 40,
                    requiredEventIds = wodTimewalkingIds,
                    entries = {
                        { quest = 55498, item = 167921 }, -- [WoD-A] The Shimmering Crystal
                        { quest = 55499, item = 167922 }, -- [WoD-H] The Shimmering Crystal
                    },
                },
                -- Legion
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 70,
                    requiredEventIds = legionTimewalkingIds,
                    entries = {
                        { quest = 72719 }, -- A Fel Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 45,
                    requiredEventIds = legionTimewalkingIds,
                    entries = {
                        { quest = 64710, item = 187611 }, -- [Legion] Whispering Felflame Crystal
                    },
                },

                {
                    key = 'worldQuests',
                    minimumLevel = 70,
                    requiredEventIds = { 592, 613, 614, 615 }, -- World Quest Bonus Event
                    entries = {
                        { quest = 72728 }, -- The World Awaits
                    },
                },
            },
        },
        {
            key = 'pvpBrawls',
            quests = {
                {
                    key = 'arathiBlizzard',
                    minimumLevel = 70,
                    requiredEventIds = { 666, 673, 680, 697, 737 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'classicAshran',
                    minimumLevel = 70,
                    requiredEventIds = { 1120, 1121, 1122, 1123, 1124 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'compStomp',
                    minimumLevel = 70,
                    requiredEventIds = { 1234, 1235, 1236, 1237, 1238 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'cookingImpossible',
                    minimumLevel = 70,
                    requiredEventIds = { 1047, 1048, 1049, 1050, 1051 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'deepSix',
                    minimumLevel = 70,
                    requiredEventIds = { 702, 704, 705, 706, 736 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'deepwindDunk',
                    minimumLevel = 70,
                    requiredEventIds = { 1239, 1240, 1241, 1242, 1243 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'gravityLapse',
                    minimumLevel = 70,
                    requiredEventIds = { 659, 663, 670, 677, 684 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'packedHouse',
                    minimumLevel = 70,
                    requiredEventIds = { 667, 674, 681, 688, 701 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'shadoPanShowdown',
                    minimumLevel = 70,
                    requiredEventIds = { 1232, 1233, 1244, 1245, 1246, 1312 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'southshoreVsTarrenMill',
                    minimumLevel = 70,
                    requiredEventIds = { 660, 662, 669, 676, 683 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'templeOfHotmogu',
                    minimumLevel = 70,
                    requiredEventIds = { 1166, 1167, 1168, 1169, 1170 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
                {
                    key = 'warsongScramble',
                    minimumLevel = 70,
                    requiredEventIds = { 664, 671, 678, 685, 1221 },
                    entries = {
                        { quest = 47148 }, -- Something Different
                    },
                },
            },
        },
    },
}
