local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionLeatherworking = {
    key = 'professions',
    order = 107,
    skillLineId = 165,
    texture = C_Spell.GetSpellTexture(2108),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2880,
            drops = {
                {
                    key = 'mob/treasure',
                    entries = {
                        { quest=83268, item=225222 }, -- Stone-Leather Swatch
                        { quest=83267, item=225223 }, -- Sturdy Nerubian Carapace
                    },
                },
            },
            quests = {
                {
                    key = 'treatise',
                    entries = {
                        { quest=83732, item=222549 }, -- Algari Treatise on Leatherworking
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=84131 }, -- Leatherworking Services Requested
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2830,
            drops = {
                {
                    key = 'mob',
                    defaultEnabled = false,
                    entries = {
                        { quest=70522, item=198975, desc='Proto-Drake' }, -- Ossified Hide
                        { quest=70523, item=198976, desc='Slyvern & Vorquin' }, -- Exceedingly Soft Skin
                    },
                },
                {
                    key = 'treasure',
                    defaultEnabled = false,
                    entries = {
                        { quest=66384, item=193910 }, -- Molted Dragon Scales
                        { quest=66385, item=193913 }, -- Preserved Animal Parts
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74928, item=204232, level=70, desc='Snarfang' }, -- Slyvern Alpha Claw
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    defaultEnabled = false,
                    entries = {
                        { quest=70567 }, -- When You Give Bakar a Bone
                        { quest=70568 }, -- Tipping the Scales
                        { quest=70569 }, -- For Trisket, a Task Kit
                        { quest=70571 }, -- Drums Here!
                    },
                },
                {
                    key = 'task',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=66363 }, -- Basilisk Bucklers
                        { quest=66364 }, -- To Fly a Kite
                        { quest=66951 }, -- Population Control
                        { quest=72407 }, -- Soaked in Success
                        { quest=75354, level=70 }, -- Mycelium Mastery [ZC]
                        { quest=75368, level=70 }, -- Stones and Scales [ZC]
                        { quest=77945, level=70 }, -- Boots on the Ground [ED]
                        { quest=77946, level=70 }, -- Fibrous Thread [ED]
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74113, item=194700 }, -- Draconic Treatise on Leatherworking
                    },
                },
                {
                    key = 'orders',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=70594 }, -- Leatherworking Services Requested
                    },
                },
            },
        },
        {
            key = 'event',
            name = L['category:event'],
            quests = {
                {
                    key = 'darkmoonFaire',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    entries = {
                        {
                            quest = 29517, -- Eye on the Prizes
                            shoppingList = {
                                { 10, 6529 }, -- Shiny Bauble
                                { 5, 2320 }, -- Coarse Thread
                                { 5, 6260 }, -- Blue Dye
                            }
                        },
                    },
                },
            },
        },
    },
}
