local _, Addon = ...
local L = Addon.L


Addon.data.professionBlacksmithing = {
    key = 'professions',
    order = 101,
    skillLineId = 164,
    texture = GetSpellTexture(2018),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2822,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70513, item=198966, desc='Fire' }, -- Molten Globule
                        { quest=70512, item=198965, desc='Earth' }, -- Primeval Earth Fragment
                    },
                },
                {
                    key = 'treasure',
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
                    key = 'craft',
                    entries = {
                        { quest=70211 }, -- Stomping Explorers
                        { quest=70233 }, -- Axe Shortage
                        { quest=70234 }, -- All This Hammering
                        { quest=70235 }, -- Repair Bill
                    },
                },
                {
                    key = 'gather',
                    entries = {
                        { quest=66517 }, -- A New Source of Weapons
                        { quest=66897 }, -- Fuel for the Forge
                        { quest=66941 }, -- Tremendous Tools
                        { quest=72398 }, -- Rock and Stone
                        { quest=75148, level=70 }, -- Ancient Techniques [ZC]
                        { quest=75569, level=70 }, -- Blacksmith, Black Dragon [ZC]
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=70589 }, -- Blacksmithing Services Requested
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74109, item=198454 }, -- Draconic Treatise on Blacksmithing
                    },
                },
            },
        },
        {
            key = 'event',
            name = L['category:event'],
            requiredEventId = 479, -- Darkmoon Faire
            quests = {
                {
                    key = 'darkmoonFaire',
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
