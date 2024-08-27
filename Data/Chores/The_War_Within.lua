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
                    key = 'awakeningTheMachine',
                    minimumLevel = 80,
                    entries = {
                        { quest = 83333 }, -- Gearing Up for Trouble
                    }
                },
                {
                    key = 'spreadingTheLight',
                    minimumLevel = 80,
                    entries = {
                        { quest = 76586 }, -- Spreading the Light
                    }
                },
                {
                    key = 'theaterTroupe',
                    minimumLevel = 70,
                    entries = {
                        { quest = 83240 }, -- The Theater Troupe
                    },
                },
                {
                    key = 'dungeon',
                    minimumLevel = 80,
                    alwaysQuestName = true,
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
                {
                    key = 'worldsoul',
                    minimumLevel = 80,
                    chooseQuest = true,
                    entries = {
                        { quest = 82511 }, -- Worldsoul: Awakening Machine
                        { quest = 82453 }, -- Worldsoul: Encore!
                        { quest = 82458 }, -- Worldsoul: Renown
                        { quest = 82516 }, -- Worldsoul: Severed Threads Pact
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
            },
        },
    },
}
