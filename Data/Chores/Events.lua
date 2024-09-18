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
    filter = function()
        -- no Remix: Pandaria aura
        return C_UnitAuras.GetPlayerAuraBySpellID(424143) == nil
    end,
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
                    requiredEventIds = { 341 }, -- Midsummer Fire Festival
                    dungeonId = 286,
                },
            },
            quests = {
                {
                    key = 'meanOne',
                    minimumLevel = 30,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 7043 }, -- You're a Mean One...
                    }
                },
            },
        },
        {
            key = 'darkmoonFaire',
            quests = {
                {
                    key = 'gameHammerTime',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=29463 }, -- It's Hammer Time
                    }
                },
                {
                    key = 'gameHumanoidCannonball',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=29436 }, -- The Humanoid Cannonball
                    }
                },
                {
                    key = 'gameHeShootsHeScores',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=29438 }, -- He Shoots, He Scores!
                    }
                },
                {
                    key = 'gameTonkCommander',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=29434 }, -- Tonk Commander
                    }
                },
                {
                    key = 'gameTargetTurtle',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=29455 }, -- Target: Turtle
                    }
                },
                {
                    key = 'gameFirebirdsChallenge',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=36481 }, -- Firebird's Challenge
                    }
                },
                {
                    key = 'race',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=37910 }, -- The Real Race
                    }
                },
                {
                    key = 'bigRace',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    alwaysQuestName = true,
                    dailyQuest = true,
                    entries = {
                        { quest=37911 }, -- The Real Big Race
                    }
                },
                {
                    key = 'petBattleJeremy',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    dailyQuest = true,
                    entries = {
                        { quest=32175, item=91086 }, -- Darkmoon Pet Battle!/Darkmoon Pet Supplies
                    }
                },
                {
                    key = 'petBattleChristoph',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    dailyQuest = true,
                    entries = {
                        { quest=36471, item=116062 }, -- A New Darkmoon Challenger!/Greater Darkmoon Pet Supplies
                    }
                },
                {
                    key = 'testYourStrength',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    entries = {
                        { quest=29433 }, -- Test Your Strength
                    }
                },
                {
                    key = 'denMother',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    entries = {
                        { quest=33354 }, -- Den Mother's Demise
                    }
                },
                {
                    key = 'aTreatiseOnStrategy',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29451, item=71715 }, -- The Master Strategist/A Treatise on Strategy
                    }
                },
                {
                    key = 'bannerOfTheFallen',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29456, item=71951 }, -- A Captured Banner/Banner of the Fallen
                    }
                },
                {
                    key = 'capturedInsignia',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29457, item=71952 }, -- The Enemy's Insignia/Captured Insignia
                    }
                },
                {
                    key = 'fallenAdventurersJournal',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29458, item=71953 }, -- The Captured Journal/Fallen Adventurer's Journal
                    }
                },
                {
                    key = 'imbuedCrystal',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29443, item=71635 }, -- A Curious Crystal/Imbued Crystal
                    }
                },
                {
                    key = 'monstrousEgg',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29444, item=71636 }, -- An Exotic Egg/Monstrous Egg
                    }
                },
                {
                    key = 'mysteriousGrimoire',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29445, item=71637 }, -- An Intriguing Grimoire/Mysterious Grimoire
                    }
                },
                {
                    key = 'ornateWeapon',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29446, item=71638 }, -- A Wondrous Weapon/Ornate Weapon
                    }
                },
                {
                    key = 'soothsayersRunes',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    onlyItemName = true,
                    entries = {
                        { quest=29464, item=71716 }, -- Tools of Divination/Soothsayer's Runes
                    }
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
                        { quest = 83358 }, -- The Arena Calls
                    },
                },
                {
                    key = 'battlegrounds',
                    minimumLevel = 70,
                    requiredEventIds = { 236 }, -- Battleground Bonus Event
                    entries = {
                        { quest = 83345 }, -- A Call to Battle
                    },
                },
                {
                    key = 'delves',
                    minimumLevel = 70,
                    requiredEventIds = { 442 }, -- Delves Bonus Event
                    entires = {
                        { quest = 84776 }, -- A Call to Delves
                    }
                },
                {
                    key = 'mythicDungeons',
                    minimumLevel = 70,
                    requiredEventIds = { 1335, 1352, 1353, 1354 }, -- Dragonflight Dungeon Event
                    entries = {
                        { quest = 83347 }, -- Emissary of War
                    },
                },
                {
                    key = 'pvpPetBattles',
                    minimumLevel = 70,
                    requiredEventIds = { 234 }, -- Pet Battle Bonus Event
                    entries = {
                        { quest = 83357 }, -- The Very Best
                    },
                },
                {
                    key = 'worldQuests',
                    minimumLevel = 70,
                    requiredEventIds = { 592, 613, 614, 615 }, -- World Quest Bonus Event
                    entries = {
                        { quest = 83366 }, -- The World Awaits
                    },
                },

                -- TBC
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 70,
                    requiredEventIds = tbcTimewalkingIds,
                    entries = {
                        { quest = 83363 }, -- A Burning Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 70,
                    requiredEventIds = tbcTimewalkingIds,
                    entries = {
                        { quest = 47523 }, -- Disturbance Detected: Black Temple
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
                        { quest = 83365 }, -- A Frozen Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 70,
                    requiredEventIds = wotlkTimewalkingIds,
                    entries = {
                        { quest = 50316 }, -- Disturbance Detected: Ulduar
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
                        { quest = 83359 }, -- A Shattered Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 70,
                    requiredEventIds = cataTimewalkingIds,
                    entries = {
                        { quest = 57637 }, -- Disturbance Detected: Firelands
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
                        { quest = 83362 }, -- A Shrouded Path Through Time
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
                        { quest = 83364 }, -- A Savage Path Through Time
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
