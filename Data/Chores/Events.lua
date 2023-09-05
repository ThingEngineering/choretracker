local _, Addon = ...
local L = Addon.L


local tbcTimewalkingIds = { 559, 622, 623, 624 }
local wotlkTimewalkingIds = { 562, 616, 617, 618 }
local cataTimewalkingIds = { 587, 628, 629, 630 }
local mopTimewalkingIds = { 643, 652, 654, 656 }
local wodTimewalkingIds = { 1056, 1063, 1065, 1068 }
local legionTimewalkingIds = { 1263, 1265, 1267, 1269, 1271, 1273, 1275, 1277 }

Addon.data.choresEvents = {
    key = 'events',
    name = L['section:events'],
    order = 0,
    categories = {
        {
            key = 'holidays',
            quests = {
                {
                    key = 'mythicDungeons',
                    minimumLevel = 70,
                    requiredEventIds = { 1335, 1352, 1353, 1354 }, -- Dragonflight Dungeon Event
                    entries = {
                        { quest=72722, item=207030 }, -- Emissary of War
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
                    requiredEventIds = legionTimewalkingIds,
                    entries = {
                        { quest = 64710, item = 187611 }, -- [Legion] Whispering Felflame Crystal
                    },
                },
            },
        },
    },
}
