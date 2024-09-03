local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionBlacksmithing = {
    key = 'professions',
    order = 101,
    skillLineId = 164,
    texture = C_Spell.GetSpellTexture(2018),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2872,
            drops = {
                {
                    key = 'mob/treasure',
                    entries = {
                        { quest=83257, item=225232 }, -- Coreway Billet
                        { quest=83256, item=225233 }, -- Dense Bladestone
                    },
                },
            },
            quests = {
                {
                    key = 'treatise',
                    entries = {
                        { quest=83726, item=222554 }, -- Algari Treatise on Blacksmithing
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=84127 }, -- Blacksmithing Services Requested
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2822,
            drops = {
                {
                    key = 'mob',
                    defaultEnabled = false,
                    entries = {
                        { quest=70513, item=198966, desc='Fire' }, -- Molten Globule
                        { quest=70512, item=198965, desc='Earth' }, -- Primeval Earth Fragment
                    },
                },
                {
                    key = 'treasure',
                    defaultEnabled = false,
                    entries = {
                        { quest=66382, item=192132 }, -- Draconium Blade Sharpener
                        { quest=66381, item=192131 }, -- Valdrakken Weapon Chain
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74931, item=204230, level=70, desc='Tidesmith Zarviss' }, -- Dense Seaforged Javelin
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    defaultEnabled = false,
                    entries = {
                        { quest=70211 }, -- Stomping Explorers
                        { quest=70233 }, -- Axe Shortage
                        { quest=70234 }, -- All This Hammering
                        { quest=70235 }, -- Repair Bill
                    },
                },
                {
                    key = 'task',
                    defaultEnabled = false,
                    entries = {
                        { quest=66517 }, -- A New Source of Weapons
                        { quest=66897 }, -- Fuel for the Forge
                        { quest=66941 }, -- Tremendous Tools
                        { quest=72398 }, -- Rock and Stone
                        { quest=75148, level=70 }, -- Ancient Techniques [ZC]
                        { quest=75569, level=70 }, -- Blacksmith, Black Dragon [ZC]
                        { quest=77935, level=70 }, -- A-Sword-ed Needs [ED]
                        { quest=77936, level=70 }, -- A Warm Harvest [ED]
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74109, item=198454 }, -- Draconic Treatise on Blacksmithing
                    },
                },
                {
                    key = 'orders',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=70589 }, -- Blacksmithing Services Requested
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
                            quest = 29508, -- Baby Needs Two Pair of Shoes
                        },
                    },
                },
            },
        },
    },
}
