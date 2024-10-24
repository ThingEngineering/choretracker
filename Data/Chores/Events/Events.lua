local _, Addon = ...
local L = Addon.L


local classicTimewalkingIds = { 1508, 1583, 1584, 1585 }
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
            key = 'holidays',
            quests = {
                {
                    key = 'delves',
                    minimumLevel = 80,
                    requiredEventIds = { 1559, 1560, 1561, 1562 }, -- Delves Bonus Event
                    entries = {
                        { quest = 84776 }, -- A Call to Delves
                    },
                },
                {
                    key = 'mythicDungeons',
                    minimumLevel = 80,
                    requiredEventIds = { 1558, 1563, 1564, 1565 }, -- The War Within Dungeon Event
                    entries = {
                        { quest = 83347 }, -- Emissary of War
                    },
                },
                {
                    key = 'pvpPetBattles',
                    minimumLevel = 80,
                    requiredEventIds = { 565, 599, 600, 601 }, -- Pet Battle Bonus Event
                    entries = {
                        { quest = 83357 }, -- The Very Best
                    },
                },
                {
                    key = 'worldQuests',
                    minimumLevel = 80,
                    requiredEventIds = { 592, 613, 614, 615 }, -- World Quest Bonus Event
                    entries = {
                        { quest = 83366 }, -- The World Awaits
                    },
                },

                -- Classic
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 1,
                    requiredEventIds = classicTimewalkingIds,
                    entries = {
                        { quest = 83274 }, -- An Original Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 30,
                    requiredEventIds = classicTimewalkingIds,
                    entries = {
                        { quest = 82817 }, -- Disturbance Detected: Blackrock Depths
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 1,
                    requiredEventIds = classicTimewalkingIds,
                    entries = {
                        { quest = 83285, item = 225348 }, -- [Classic] The Ancient Scroll
                    },
                },
                -- TBC
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 80,
                    requiredEventIds = tbcTimewalkingIds,
                    entries = {
                        { quest = 83363 }, -- A Burning Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 30,
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
                    minimumLevel = 80,
                    requiredEventIds = wotlkTimewalkingIds,
                    entries = {
                        { quest = 83365 }, -- A Frozen Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 30,
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
                    minimumLevel = 80,
                    requiredEventIds = cataTimewalkingIds,
                    entries = {
                        { quest = 83359 }, -- A Shattered Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 35,
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
                    minimumLevel = 80,
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
                    minimumLevel = 80,
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
                    minimumLevel = 80,
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
            defaultEnabled = false,
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
    },
}
