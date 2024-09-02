local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionJewelcrafting = {
    key = 'professions',
    order = 106,
    skillLineId = 755,
    texture = C_Spell.GetSpellTexture(25229),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2879,
            drops = {
                {
                    key = 'mob/treasure',
                    entries = {
                        { quest=83266, item=225225 }, -- Deepstone Fragment
                        { quest=83265, item=225224 }, -- Diaphanous Gem Shards
                    },
                },
            },
            quests = {
                {
                    key = 'treatise',
                    entries = {
                        { quest=83731, item=222551 }, -- Algari Treatise on Jewelcrafting
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=84130 }, -- Jewelcrafting Services Requested
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2829,
            drops = {
                {
                    key = 'mob',
                    defaultEnabled = false,
                    entries = {
                        { quest=70520, item=198973, desc='Elemental' }, -- Incandescent Curio
                        { quest=70521, item=198974, desc='Dragonkin' }, -- Elegantly Engraved Embellishment
                    },
                },
                {
                    key = 'treasure',
                    defaultEnabled = false,
                    entries = {
                        { quest=66388, item=193909 }, -- Ancient Gem Fragments
                        { quest=66389, item=193907 }, -- Chipped Tyrstone
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74936, item=204222, level=70, desc='Amephyst' }, -- Conductive Ametrine Shard
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    skill = 50,
                    defaultEnabled = false,
                    entries = {
                        { quest=70562 }, -- The Plumbers, Mason
                        { quest=70563 }, -- The Exhibition
                        { quest=70564 }, -- Spectacular
                        { quest=70565 }, -- Separation by Saturation
                    },
                },
                {
                    key = 'task',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=66516 }, -- Mundane Gems, I Think Not!
                        { quest=66949 }, -- Trinket Bandits
                        { quest=66950 }, -- Heart of a Giant
                        { quest=72428 }, -- Hornswog Hoarders
                        { quest=75362, level=70 }, -- Cephalo-crystalization [ZC]
                        { quest=75602, level=70 }, -- Chips off the Old Crystal Block [ZC]
                        { quest=77892, level=70 }, -- Pearls of Great Value [ED]
                        { quest=77912, level=70 }, -- Unmodern Jewelry [ED]
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74112, item=194703 }, -- Draconic Treatise on Jewelcrafting
                    },
                },
                {
                    key = 'orders',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=70593 }, -- Jewelcrafting Services Requested
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
                            quest = 29516, -- Keeping the Faire Sparkling
                        },
                    },
                },
            },
        },
    },
}
