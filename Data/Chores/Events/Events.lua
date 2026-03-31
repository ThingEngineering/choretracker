local _, Addon = ...
local L = Addon.L


local classicTimewalkingIds = { 1508, 1583, 1584, 1585 }
local tbcTimewalkingIds = { 559, 622, 623, 624 }
local wotlkTimewalkingIds = { 562, 616, 617, 618 }
local cataTimewalkingIds = { 587, 628, 629, 630 }
local mopTimewalkingIds = { 643, 652, 654, 656 }
local wodTimewalkingIds = { 1056, 1063, 1065, 1068 }
local legionTimewalkingIds = { 1263, 1265, 1267, 1269, 1271, 1273, 1275, 1277 }
local bfaTimewalkingIds = { 1666, 1667, 1668, 1669 }
local slTimewalkingIds = { 1703, 1704, 1705, 1706, 1707, 1708, 1709, 1710 }

Addon.data.chores.choresEvents = {
    key = 'events',
    name = L['section:events'],
    order = 0,
    categories = {
        {
            key = 'special',
            quests = {
                {
                    key = 'turboBoost',
                    minimumLevel = 80,
                    -- requiredQuest = 86204, -- Liberation of Undermine: The House Loses
                    entries = {
                        { quest = 91205 }, -- Ultra Prime Deluxe Turbo-Boost: Powerhouse Challenges
                    },
                },
                {
                    key = 'prepatchDisruptTheCall',
                    minimumLevel = 10,
                    -- requiredQuest = 90768, -- Cult it Out (account?)
                    entries = {
                        { quest = 91795 }, -- Disrupt the Call
                    },
                },
                {
                    key = 'prepatchTwilightsDawn',
                    minimumLevel = 10,
                    -- requiredQuest = 90768, -- Cult it Out (account?)
                    entries = {
                        { quest = 87308 }, -- Twilight's Dawn
                    },
                },
            },
        },
        {
            key = 'holidays',
            quests = {
                {
                    key = 'delves',
                    minimumLevel = 90,
                    requiredEventIds = { 1559, 1560, 1561, 1562 }, -- Delves Bonus Event
                    entries = {
                        { quest = 93595 }, -- A Call to Delves
                    },
                },
                {
                    key = 'mythicDungeons',
                    minimumLevel = 80,
                    requiredEventIds = { 1558, 1563, 1564, 1565 }, -- The War Within Dungeon Event
                    entries = {
                        { quest = 93598 }, -- Emissary of War
                    },
                },
                {
                    key = 'pvpPetBattles',
                    minimumLevel = 90,
                    requiredEventIds = { 565, 599, 600, 601 }, -- Pet Battle Bonus Event
                    entries = {
                        { quest = 93599 }, -- The Very Best
                    },
                },
                {
                    key = 'worldQuests',
                    minimumLevel = 80,
                    requiredEventIds = { 592, 613, 614, 615 }, -- World Quest Bonus Event
                    entries = {
                        { quest = 93605 }, -- The World Awaits
                    },
                },

                -- Classic
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 10,
                    requiredEventIds = classicTimewalkingIds,
                    entries = {
                        { quest = 85947 }, -- An Original Journey Through Time
                        { quest = 93607 }, -- An Original Path Through Time
                    },
                },
                -- {
                --     key = 'timewalkingRaids',
                --     minimumLevel = 30,
                --     requiredEventIds = classicTimewalkingIds,
                --     entries = {
                --         { quest = 82817 }, -- Disturbance Detected: Blackrock Depths
                --     },
                -- },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = classicTimewalkingIds,
                    entries = {
                        { quest = 83285, item = 225348 }, -- [Classic] The Ancient Scroll
                    },
                },
                -- TBC
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 10,
                    requiredEventIds = tbcTimewalkingIds,
                    entries = {
                        { quest = 85948 }, -- A Burning Journey Through Time
                        { quest = 93608 }, -- A Burning Path Through Time
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
                    minimumLevel = 10,
                    requiredEventIds = wotlkTimewalkingIds,
                    entries = {
                        { quest = 85949 }, -- A Frozen Journey Through Time
                        { quest = 93610 }, -- A Frozen Path Through Time
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
                    minimumLevel = 10,
                    requiredEventIds = cataTimewalkingIds,
                    entries = {
                        { quest = 86556 }, -- A Shattered Journey Through Time
                        { quest = 93611 }, -- A Shattered Path Through Time
                    },
                },
                {
                    key = 'timewalkingRaids',
                    minimumLevel = 30,
                    requiredEventIds = cataTimewalkingIds,
                    entries = {
                        { quest = 57637 }, -- Disturbance Detected: Firelands
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = cataTimewalkingIds,
                    entries = {
                        { quest = 40786, item = 133377 }, -- [Cata-H] The Smoldering Ember
                        { quest = 40787, item = 133378 }, -- [Cata-A] The Smoldering Ember
                    },
                },
                -- MoP
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 10,
                    requiredEventIds = mopTimewalkingIds,
                    entries = {
                        { quest = 86560 }, -- A Shrouded Journey Through Time
                        { quest = 93612 }, -- A Shrouded Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = mopTimewalkingIds,
                    entries = {
                        { quest = 45563, item = 143776 }, -- [MoP] The Shrouded Coin
                    },
                },
                -- WoD
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 10,
                    requiredEventIds = wodTimewalkingIds,
                    entries = {
                        { quest = 86563 }, -- A Savage Journey Through Time
                        { quest = 93613 }, -- A Savage Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = wodTimewalkingIds,
                    entries = {
                        { quest = 55498, item = 167921 }, -- [WoD-A] The Shimmering Crystal
                        { quest = 55499, item = 167922 }, -- [WoD-H] The Shimmering Crystal
                    },
                },
                -- Legion
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 10,
                    requiredEventIds = legionTimewalkingIds,
                    entries = {
                        { quest = 86564 }, -- A Fel Journey Through Time
                        { quest = 93614 }, -- A Fel Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = legionTimewalkingIds,
                    entries = {
                        { quest = 64710, item = 187611 }, -- [Legion] Whispering Felflame Crystal
                    },
                },
                -- Battle for Azeroth
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 10,
                    requiredEventIds = bfaTimewalkingIds,
                    entries = {
                        { quest = 88808 }, -- A Scarred Journey Through Time
                        { quest = 93627 }, -- A Scarred Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = bfaTimewalkingIds,
                    entries = {
                        { quest = 89222, item = 238790 }, -- [BfA-A] Remnant of Azeroth
                        { quest = 89223, item = 238791 }, -- [BfA-H] Remnant of Azeroth
                    },
                },
                -- Shadowlands
                {
                    key = 'timewalkingDungeons',
                    minimumLevel = 10,
                    requiredEventIds = slTimewalkingIds,
                    entries = {
                        { quest = 92647 }, -- A Shadowed Journey Through Time
                        { quest = 92649 }, -- A Shadowed Path Through Time
                        { quest = 93628 }, -- A Shadowed Path Through Time
                    },
                },
                {
                    key = 'timewalkingTurnIn',
                    minimumLevel = 30,
                    requiredEventIds = slTimewalkingIds,
                    entries = {
                        { quest = 92650, item = 253517 }, -- [SL] The Flickering Anima
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
                        { quest = 7043 }, -- [A] You're a Mean One...
                        { quest = 6983 }, -- [H] You're a Mean One...
                    }
                },
                {
                    key = 'grumpus',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39651 }, -- Grumpus
                    }
                },
                {
                    key = 'menacingGrumplings',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39649 }, -- Menacing Grumplings
                    }
                },
                {
                    key = 'whatHorriblePresents',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39668 }, -- What Horrible Presents!
                    }
                },
                {
                    key = 'whereAreTheChildren',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39648 }, -- Where Are the Children?
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
