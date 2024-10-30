local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresWarWithin = {
    key = 'warWithin',
    name = EXPANSION_NAME10,
    order = 20,
    minimumLevel = 70,
    categories = {
        {
            key = 'patch_11_0_0',
            quests = {
                {
                    key = 'worldBoss',
                    minimumLevel = 80,
                    alwaysQuestName = true,
                    entries = {
                        { quest = 81624 }, -- Orta, the Broken Mountain
                        { quest = 81630 }, -- Kordac, the Dormant Protector
                        { quest = 81653 }, -- Shurrai, Atrocity of the Undersea
                        { quest = 83466, actualQuest = 82653 }, -- Aggregation of Horrors
                    }
                },
                {
                    key = 'delveKeys',
                    minimumLevel = 80,
                    groupSameItem = true,
                    entries = {
                        { quest=84736, item=224172 }, -- Restored Coffer Key
                        { quest=84737, item=224172 }, -- Restored Coffer Key
                        { quest=84738, item=224172 }, -- Restored Coffer Key
                        { quest=84739, item=224172 }, -- Restored Coffer Key
                    },
                },
                {
                    key = 'emissaryArchives',
                    minimumLevel = 70,
                    entries = {
                        { quest = 82679 }, -- Archives: Seeking History
                        { quest = 82678 }, -- Archives: The First Disc
                    },
                },
                {
                    key = 'emissaryDelves',
                    minimumLevel = 70,
                    entries = {
                        { quest = 82746 }, -- Delves: Breaking Tough to Loot Stuff
                        { quest = 82707 }, -- Delves: Earthen Defense
                        { quest = 82710 }, -- Delves: Empire-ical Exploration
                        { quest = 82706 }, -- Delves: Khaz Algar Research
                        { quest = 82711 }, -- Delves: Lost and Found
                        { quest = 82708 }, -- Delves: Nerubian Menace
                        { quest = 82709 }, -- Delves: Percussive Archaeology
                        { quest = 82712 }, -- Delves: Trouble Up and Down Khaz Algar
                    },
                },
                {
                    key = 'emissaryWorldsoul',
                    minimumLevel = 70,
                    entries = {
                        { quest = 82511 }, -- Worldsoul: Awakening Machine
                        { quest = 82453 }, -- Worldsoul: Encore!
                        { quest = 82516 }, -- Worldsoul: Forging a Pact
                        { quest = 82458 }, -- Worldsoul: Renown
                        { quest = 82482 }, -- Worldsoul: Snuffling
                        { quest = 82483 }, -- Worldsoul: Spreading the Light
                        { quest = 82512 }, -- Worldsoul: World Boss
                        { quest = 82452 }, -- Worldsoul: World Quests
                        { quest = 82491 }, -- Worldsoul: Ara-Kara, City of Echoes [N]
                        { quest = 82494 }, -- Worldsoul: Ara-Kara, City of Echoes [H]
                        { quest = 82502 }, -- Worldsoul: Ara-Kara, City of Echoes [M]
                        { quest = 82485 }, -- Worldsoul: Cinderbrew Meadery [N]
                        { quest = 82495 }, -- Worldsoul: Cinderbrew Meadery [H]
                        { quest = 82503 }, -- Worldsoul: Cinderbrew Meadery [M]
                        { quest = 82492 }, -- Worldsoul: City of Threads [N]
                        { quest = 82496 }, -- Worldsoul: City of Threads [H]
                        { quest = 82504 }, -- Worldsoul: City of Threads [M]
                        { quest = 82488 }, -- Worldsoul: Darkflame Cleft [N]
                        { quest = 82498 }, -- Worldsoul: Darkflame Cleft [H]
                        { quest = 82506 }, -- Worldsoul: Darkflame Cleft [M]
                        { quest = 82490 }, -- Worldsoul: Priory of the Sacred Flame [N]
                        { quest = 82499 }, -- Worldsoul: Priory of the Sacred Flame [H]
                        { quest = 82507 }, -- Worldsoul: Priory of the Sacred Flame [M]
                        { quest = 82489 }, -- Worldsoul: The Dawnbreaker [N]
                        { quest = 82493 }, -- Worldsoul: The Dawnbreaker [H]
                        { quest = 82501 }, -- Worldsoul: The Dawnbreaker [M]
                        { quest = 82486 }, -- Worldsoul: The Rookery [N]
                        { quest = 82500 }, -- Worldsoul: The Rookery [H]
                        { quest = 82508 }, -- Worldsoul: The Rookery [M]
                        { quest = 82487 }, -- Worldsoul: The Stonevault [N]
                        { quest = 82497 }, -- Worldsoul: The Stonevault [H]
                        { quest = 82505 }, -- Worldsoul: The Stonevault [M]
                        { quest = 82509 }, -- Worldsoul: Nerub-ar Palace [LFR]
                        { quest = 82659 }, -- Worldsoul: Nerub-ar Palace [N]
                        { quest = 82510 }, -- Worldsoul: Nerub-ar Palace [H]
                    },
                },
                {
                    key = 'specialAssignment',
                    minimumLevel = 70,
                    pick = 2,
                    alwaysShowObjectives = true,
                    removeText = L['remove_specialAssignment'],
                    entries = {
                        { quest = 82414, unlockQuest = 82159 }, -- Special Assignment: A Pound of Cure
                        { quest = 82531, unlockQuest = 82161 }, -- Special Assignment: Bombs From Behind
                        { quest = 82355, unlockQuest = 82146 }, -- Special Assignment: Cinderbee Surge
                        { quest = 82852, unlockQuest = 82158 }, -- Special Assignment: Lynx Rescue
                        { quest = 82787, unlockQuest = 82157 }, -- Special Assignment: Rise of the Colossals
                        { quest = 81691, unlockQuest = 82155 }, -- Special Assignment: Shadows Below
                        -- Why are there 3?
                        { quest = 81647, unlockQuest = 82154 }, -- Special Assignment: Titanic Resurgence
                        { quest = 81649, unlockQuest = 83069 }, -- Special Assignment: Titanic Resurgence
                        { quest = 81650, unlockQuest = 83070 }, -- Special Assignment: Titanic Resurgence
                        { quest = 83229, unlockQuest = 82156 }, -- Special Assignment: When the Deeps Stir
                    },
                },
                {
                    key = 'spreadingTheLight',
                    minimumLevel = 70,
                    entries = {
                        { quest = 76586 }, -- Spreading the Light
                    }
                },
                {
                    key = 'spiderPact',
                    minimumLevel = 70,
                    entries = {
                        { quest = 80544 }, -- The Weaver
                        { quest = 80545 }, -- The General
                        { quest = 80546 }, -- The Vizier
                    },
                },
                {
                    key = 'spiderWeekly',
                    minimumLevel = 70,
                    alwaysShowObjectives = true,
                    entries = {
                        { quest = 80670 }, -- Eyes of the Weaver
                        { quest = 80671 }, -- Blade of the General
                        { quest = 80672 }, -- Hand of the Vizier
                    },
                },
                {
                    key = 'theaterTroupe',
                    minimumLevel = 80,
                    entries = {
                        { quest = 83240 }, -- The Theater Troupe
                    },
                },
                {
                    key = 'awakeningTheMachine',
                    minimumLevel = 70,
                    entries = {
                        { quest = 83333 }, -- Gearing Up for Trouble
                    }
                },
                {
                    key = 'rollinDown',
                    minimumLevel = 80,
                    entries = {
                        { quest = 82946 }, -- Rollin' Down in the Deeps
                    }
                },
                {
                    key = 'dungeon',
                    minimumLevel = 80,
                    alwaysQuestName = true,
                    oncePerAccount = true, -- rewards suck
                    entries = {
                        { quest = 83465 }, -- Ara-Kara, City of Echoes
                        { quest = 83436 }, -- Cinderbrew Meadery
                        { quest = 83469 }, -- City of Threads
                        { quest = 83443 }, -- Darkflame Cleft
                        { quest = 83458 }, -- Priory of the Sacred Flame
                        { quest = 83459 }, -- The Dawnbreaker
                        { quest = 83432 }, -- The Rookery
                        { quest = 83457 }, -- The Stonevault
                    },
                },
            },
        },
    },
}
