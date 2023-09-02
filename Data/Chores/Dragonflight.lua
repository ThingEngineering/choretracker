local _, Addon = ...
local L = Addon.L


Addon.data.choresDragonflight = {
    key = 'choresDragonflight',
    name = L['dragonflight_chores'],
    order = 0,
    categories = {
        {
            key = 'patch_10_1_5',
            quests = {
                {
                    key = 'timeRift',
                    entries = {
                        { quest=77836, item=207030 }, -- HTQ, Dilated Time Capsule
                    }
                }
            },
        },
        {
            key = 'patch_10_1_0',
            quests = {
                {
                    key = 'aWorthyAlly',
                    entries = {
                        { quest = 75665 }, -- A Worthy Ally: Loamm Niffen
                    }
                },
                {
                    key = 'barter',
                    requiredQuest = 75721,
                    entries = {
                        { quest=75286 }, -- Blacksmith's Back
                        -- { quest=75288 }, -- Enchanted Tales with Topuiz
                        -- { quest=75289 }, -- Ink Master
                        -- { quest=75301 }, -- Mistie's Mix Magic
                        -- { quest=75304 }, -- I Need... a Tailor
                        -- { quest=75307 }, -- Road to Season City
                        -- { quest=75308 }, -- Scrybbil Engineering
                        -- { quest=75309 }, -- If a Gem Isn't Pretty
                        -- { quest=75351 }, -- Keep a Leather Eye Open
                    },
                },
                {
                    key = 'barter',
                    requiredQuest = 75721,
                    entries = {
                        -- { quest=75288 }, -- Enchanted Tales with Topuiz
                        -- { quest=75289 }, -- Ink Master
                        -- { quest=75301 }, -- Mistie's Mix Magic
                        -- { quest=75304 }, -- I Need... a Tailor
                        { quest=75307 }, -- Road to Season City
                        -- { quest=75308 }, -- Scrybbil Engineering
                        -- { quest=75309 }, -- If a Gem Isn't Pretty
                        -- { quest=75351 }, -- Keep a Leather Eye Open
                    },
                },
                {
                    key = 'fyrakkAssault',
                    entries = {
                        { quest=75157 }, -- First completion HTQ
                        { quest=75280 }, -- Azure Span WQ
                        { quest=74501 }, -- Ohn'ahran Plains WQ
                    },
                },
                {
                    key = 'fyrakkDisciple',
                    entries = {
                        { quest=75467 }, -- Killed disciple HTQ
                    },
                },
                {
                    key = 'fyrakkShipment',
                    entries = {
                        { quest=74526 }, -- Azure Span HTQ
                        { quest=75525 }, -- Ohn'ahran Plains HTQ
                    },
                },
            },
        },
        -- patch_10_0_7 = {
        --     name = L['patch_10_0_7'],
        --     quests = {
        --         {
        --             key = 'stormsChest',
        --             entries = {
        --                 { quest=74567 }, -- ? HTQ
        --             },
        --         },
        --         {
        --             key = 'stormsEvent',
        --             entries = {
        --                 { quest=75399 }, -- Water HTQ
        --                 { quest=75400 }, -- Fire HTQ
        --                 { quest=75401 }, -- Earth HTQ
        --                 { quest=75402 }, -- Air HTQ
        --             },
        --         }
        --     },
        -- },
        {
            key = 'patch_10_0_0',
            quests = {
                {
                    key = 'aidingTheAccord',
                    inProgressQuestName = false,
                    entries = {
                        { quest = 70750 }, -- Aiding the Accord
                        { quest = 72068 }, -- Aiding the Accord: A Feast For All
                        { quest = 72373 }, -- Aiding the Accord: A Hunt Is On
                        { quest = 72374 }, -- Aiding the Accord: Dragonbane Keep
                        { quest = 72375 }, -- Aiding the Accord: The Isles Call
                        { quest = 75259 }, -- Aiding the Accord: Zskera Vaults
                        { quest = 75859 }, -- Aiding the Accord: Sniffenseeking
                        { quest = 75860 }, -- Aiding the Accord: Researchers Under Fire
                        { quest = 75861 }, -- Aiding the Accord: Suffusion Camp
                        { quest = 77254 }, -- Aiding the Accord: Time Rift
                    },
                },
                {
                    key = 'communityFeast',
                    entries = {
                        { quest = 70893, item=200095 }, -- HTQ
                    },
                },
                {
                    key = 'dragonAllegiance',
                    entries = {
                        { quest = 66419 }, -- HTQ
                    },
                },
                {
                    key = 'dragonKey',
                    entries = {
                        { quest = 66133 }, -- Wrathion HTQ
                        { quest = 66805 }, -- Sabellian HTQ
                    },
                },
                {
                    key = 'dragonbaneKeep',
                    entries = {
                        { quest = 70866 }, -- HTQ
                    },
                },
                {
                    key = 'grandHuntUncommon',
                    entries = {
                        { quest = 71137 }, -- HTQ
                    },
                },
                {
                    key = 'grandHuntRare',
                    entries = {
                        { quest = 71136 }, -- HTQ
                    },
                },
                {
                    key = 'grandHuntEpic',
                    entries = {
                        { quest = 70906 }, -- HTQ
                    },
                },
            },
        },
    },
}