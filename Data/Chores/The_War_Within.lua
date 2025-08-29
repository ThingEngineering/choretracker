local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresWarWithin = {
    key = 'warWithin',
    name = EXPANSION_NAME10,
    order = 20,
    minimumLevel = 70,
    categories = {
        {
            key = 'patch_11_2_0',
            minimumLevel = 70,
            quests = {
                {
                    key = 'worldBoss',
                    minimumLevel = 80,
                    oncePerAccount = true,
                    entries = {
                        { quest = 87352, actualQuest = 87354 }, -- The Main Event
                    },
                },
                {
                    key = 'ecologicalSuccession',
                    minimumLevel = 70,
                    entries = {
                        { quest = 85460 },
                    },
                },
                {
                    key = 'makingDeposit',
                    minimumLevel = 80,
                    pick = 4,
                    entries = {
                        { quest = 89062 }, -- Devourer Attack: The Atrium
                        { quest = 89061 }, -- Devourer Attack: Eco-dome: Primus
                        { quest = 85722 }, -- Devourer Attack: The Oasis
                        { quest = 89063 }, -- Devourer Attack: Tazavesh
                    }
                },
                {
                    key = 'moreThanPhase',
                    minimumLevel = 80,
                    requiredQuest = 89345, -- The Untethered Horror
                    entries = {
                        { quest = 91093 }, -- More Than Just a Phase
                    }
                },
                {
                    key = 'specialAssignment',
                    minimumLevel = 80,
                    entries = {
                        {
                            quest = 89293, -- Overshadowed
                            unlockQuest = 91193, -- Capstone 1 - Unlock
                        },
                        {
                            quest = 89294, -- Aligned Views
                            unlockQuest = 91203, -- Capstone 2 - Unlock
                        },
                    },
                },
                {
                    key = 'warrant',
                    minimumLevel = 80,
                    -- oncePerAccount = true, -- rewards suck?
                    entries = {
                        { quest = 90122, unlockQuest = 87345 }, -- Eliminate Xy'vox the Twisted
                        { quest = 90123, unlockQuest = 87343 }, -- Eliminate Hollowbane
                        { quest = 90124, unlockQuest = 87001 }, -- Eliminate Shatterpulse
                        { quest = 90125, unlockQuest = 87546 }, -- Eliminate Purple Peat
                        { quest = 90126, unlockQuest = 87405 }, -- Eliminate Grubber
                        { quest = 90127, unlockQuest = 89490 }, -- Eliminate Arcana-Monger So'zer
                    },
                }
            },
        },
        {
            key = 'patch_11_1_5',
            minimumLevel = 70,
            quests = {
                {
                    key = 'nightfallScenario',
                    minimumLevel = 70,
                    entries = {
                        { quest = 89295 }, -- The Flame Burns Eternal
                        { quest = 91173 }, -- The Flame Burns Eternal
                    },
                },
                {
                    key = 'nightfallIncursion',
                    minimumLevel = 70,
                    pick = 3,
                    entries = {
                        { quest = 87475 }, -- Sureki Incursion: Hold the Wall
                        { quest = 87477 }, -- Sureki Incursion: Southern Swarm
                        { quest = 87480 }, -- Sureki Incursion: The Eastern Assault
                        { quest = 88711 }, -- Radiant Incursion: Toxins and Pheromones
                        { quest = 88916 }, -- Radiant Incursion: Sureki's End
                        { quest = 88945 }, -- Radiant Incursion: Rak-Zakaz
                    },
                },
            },
        },
        {
            key = 'patch_11_1_0',
            minimumLevel = 80,
            quests = {
                {
                    key = 'worldBoss',
                    minimumLevel = 80,
                    oncePerAccount = true,
                    entries = {
                        { quest = 89401, actualQuest = 85088 }, -- The Main Event
                    },
                },
                {
                    key = 'cartelChoose',
                    oncePerAccount = true,
                    minimumLevel = 80,
                    entries = {
                        { quest = 84948 }, -- Contract Work
                        -- 84951?
                    },
                },
                {
                    key = 'chettGet',
                    minimumLevel = 80,
                    entries = {
                        { quest = 5000002 },
                    },
                },
                {
                    key = 'chett',
                    minimumLevel = 80,
                    need = 4,
                    pick = 8,
                    requiredQuest = 5000002,
                    entries = {
                        { quest = 86915 }, -- Side with a Cartel
                        { quest = 86919 }, -- Side Gig
                        { quest = 87304 }, -- Time to Vacate [Excavation Site 9]
                        { quest = 87303 }, -- Clean the Sidestreets [Sidestreet Sluice]
                        { quest = 87305 }, -- Desire to D.R.I.V.E. [2x race]
                        { quest = 87302 }, -- Rare Rivals [3x rare]
                        { quest = 86924 }, -- Gotta Catch at Least a Few [5x battle pet]
                        { quest = 86920 }, -- War Mode Violence [5x war mode kill]
                        { quest = 86917 }, -- Ship Right [10x job]
                        { quest = 87307 }, -- Garbage Day [25x trash]
                        { quest = 87306 }, -- Kaja Cruising [50x car can]
                        { quest = 86923 }, -- Go Fish [50x fishing]
                        { quest = 86918 }, -- Reclaimed Scrap [100x empty can]
                    },
                },
                {
                    key = 'chettTurnIn',
                    minimumLevel = 80,
                    entries = {
                        { quest = 5000003 },
                    },
                },
                {
                    key = 'specialAssignment',
                    minimumLevel = 80,
                    entries = {
                        {
                            quest = 85487, -- Boom! Headshot!
                            unlockQuest = 85489, -- Capstone 1 - Unlock
                        },
                        {
                            quest = 85488, -- Security Detail
                            unlockQuest = 85490, -- Capstone 2 - Unlock
                        },
                    },
                },
                {
                    key = 'jobs',
                    minimumLevel = 80,
                    entries = {
                        { quest = 85869 }, -- Many Jobs, Handle It! [S&H]
                    },
                },
                {
                    key = 'scrap',
                    minimumLevel = 80,
                    entries = {
                        { quest = 85879 }, -- Reduce, Resuse, Resell [SCRAP]
                    },
                },
                {
                    key = 'surge',
                    minimumLevel = 80,
                    entries = {
                        { quest = 86775 }, -- Urge to Surge [S&H]
                    },
                },
                {
                    key = 'sideGigs',
                    minimumLevel = 80,
                    pick = 4,
                    entries = {
                        { quest = 85944 }, -- Side Gig: Blood Type
                        { quest = 85945 }, -- Side Gig: Blood-B-Gone
                        { quest = 86178 }, -- Side Gig: Cleanin' the Coast
                        { quest = 85913 }, -- Side Gig: Cleanup Detail
                        { quest = 85914 }, -- Side Gig: Coolant Matters
                        { quest = 85553 }, -- Side Gig: Feeling Crabby
                        { quest = 86180 }, -- Side Gig: Infested Waters
                        { quest = 85554 }, -- Side Gig: It's Always Sunny Side Up
                        { quest = 85960 }, -- Side Gig: Lost in the Sauce
                        { quest = 86179 }, -- Side Gig: Lucky Break's Big Break
                        { quest = 86177 }, -- Side Gig: The Tides Provide
                        { quest = 85962 }, -- Side Gig: Unseemly Reagents
                    },
                },
            },
        },
        {
            key = 'patch_11_0_7',
            quests = {
                {
                    key = 'specialAssignment',
                    minimumLevel = 80,
                    entries = {
                        {
                            quest = 85113, -- Special Assignment: Storm's a Brewin
                            unlockQuest = 84850, -- Serpent's Wrath
                        },
                        {
                            quest = 85113, -- Special Assignment: Storm's a Brewin
                            unlockQuest = 84851, -- Tides of Greed
                        },
                        {
                            quest = 85113, -- Special Assignment: Storm's a Brewin
                            unlockQuest = 84852, -- Legacy of the Vrykul
                        },
                    },
                },
                {
                    key = 'storm',
                    minimumLevel = 80,
                    requiredQuest = 85070, -- Storm available?
                    pick = 2,
                    entries = {
                        { quest = 84225 }, -- Eggstinction
                        { quest = 84241 }, -- Shoreline Stand
                    },
                },
                {
                    key = 'weeklies',
                    minimumLevel = 80,
                    pick = 5,
                    entries = {
                        -- Naga
                        { quest = 84252 }, -- Peak Precision
                        { quest = 84430 }, -- Crystal Crusade
                        { quest = 84627 }, -- Three Heads of the Deep
                        { quest = 85051 }, -- Beach Comber
                        { quest = 85589 }, -- Ruffled Pages
                        -- Pirate
                        { quest = 83753 }, -- Cannon Karma
                        { quest = 83827 }, -- Silence the Song
                        { quest = 84001 }, -- Cart Blanche
                        { quest = 84299 }, -- Pirate Plunder
                        { quest = 84619 }, -- Ooker Dooker Literature Club
                        -- Vrykul
                        { quest = 84248 }, -- A Ritual of Runes
                        { quest = 83932 }, -- Historical Documents
                        { quest = 84432 }, -- Longship Landing
                        { quest = 84680 }, -- Rock 'n Stone Revival
                        { quest = 84222 }, -- Secure the Perimeter
                    },
                },
            },
        },
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
                    key = 'delveArchaic',
                    minimumLevel = 70,
                    oncePerAccount = true,
                    entries = {
                        { quest=84370, item=227794 },
                    },
                },
                {
                    key = 'delveGilded',
                    minimumLevel = 80,
                    entries = {
                        { quest=5000001 },
                    },
                },
                {
                    key = 'delveKeys',
                    minimumLevel = 80,
                    groupSameItem = true,
                    entries = {
                        { quest=91175, item=238526 }, -- Restored Coffer Key
                        { quest=91176, item=238526 }, -- Restored Coffer Key
                        { quest=91177, item=238526 }, -- Restored Coffer Key
                        { quest=91178, item=238526 }, -- Restored Coffer Key
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
                        { quest = 82711 }, -- Delves: Lost and Found
                        { quest = 82708 }, -- Delves: Nerubian Menace
                        { quest = 82709 }, -- Delves: Percussive Archaeology
                        { quest = 82712 }, -- Delves: Trouble Up and Down Khaz Algar
                        { quest = 82706 }, -- Delves: Worldwide Research
                    },
                },
                {
                    key = 'emissaryWorldsoul',
                    minimumLevel = 70,
                    entries = {
                        { quest = 82511 }, -- Worldsoul: Awakening Machine
                        { quest = 87419 }, -- Worldsoul: Delves
                        { quest = 87417 }, -- Worldsoul: Dungeons
                        { quest = 82453 }, -- Worldsoul: Encore!
                        { quest = 82516 }, -- Worldsoul: Forging a Pact
                        { quest = 89514 }, -- Worldsoul: Horrific Visions Revisited
                        { quest = 91855 }, -- Worldsoul: K'aresh World Quests
                        { quest = 89502 }, -- Worldsoul: Nightfall
                        { quest = 91052 }, -- Worldsoul: Overcharged Delves
                        { quest = 82458 }, -- Worldsoul: Renown
                        { quest = 82482 }, -- Worldsoul: Snuffling
                        { quest = 82483 }, -- Worldsoul: Spreading the Light
                        { quest = 87423 }, -- Worldsoul: Undermine Explorer
                        { quest = 87422 }, -- Worldsoul: Undermine World Quests
                        { quest = 82512 }, -- Worldsoul: World Boss
                        { quest = 87424 }, -- Worldsoul: World Bosses
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
                        { quest = 86203 }, -- Operation: Floodgate
                    },
                },
            },
        },
    },
}
