local _, Addon = ...


Addon.data.quests = {
    patch_10_1_5 = {
        quests = {
            {
                key = 'timeRift',
                entries = {
                    { quest=77836 }, -- HTQ
                }
            }
        },
    },
    patch_10_1_0 = {
        quests = {
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
    patch_10_0_7 = {
        quests = {
            {
                key = 'stormsChest',
                entries = {
                    { quest=74567 }, -- ? HTQ
                },
            },
            {
                key = 'stormsEvent',
                entries = {
                    { quest=75399 }, -- Water HTQ
                    { quest=75400 }, -- Fire HTQ
                    { quest=75401 }, -- Earth HTQ
                    { quest=75402 }, -- Air HTQ
                },
            }
        },
    },
    patch_10_0_0 = {
        quests = {
            {
                key = 'communityFeast',
                entries = {
                    { quest = 70893 }, -- HTQ
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
}
