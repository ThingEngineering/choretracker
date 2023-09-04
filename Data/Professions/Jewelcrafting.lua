local _, Addon = ...
local L = Addon.L


Addon.data.professionJewelcrafting = {
    order = 106,
    skillLineId = 755,
    texture = GetSpellTexture(25229),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2829,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70520, item=198973, desc='Elemental' }, -- Incandescent Curio
                        { quest=70521, item=198974, desc='Dragonkin' }, -- Elegantly Engraved Embellishment
                    },
                },
                {
                    key = 'treasure',
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
                    key = 'craft',
                    entries = {
                        { quest=70562 }, -- The Plumbers, Mason
                        { quest=70563 }, -- The Exhibition
                        { quest=70564 }, -- Spectacular
                        { quest=70565 }, -- Separation by Saturation
                    },
                },
                {
                    key = 'gather',
                    entries = {
                        { quest=66516 }, -- Mundane Gems, I Think Not!
                        { quest=66949 }, -- Trinket Bandits
                        { quest=66950 }, -- Heart of a Giant
                        { quest=72428 }, -- Hornswog Hoarders
                        { quest=75362, level=70 }, -- Cephalo-crystalization [ZC]
                        { quest=75602, level=70 }, -- Chips off the Old Crystal Block [ZC]
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=70593 }, -- Jewelcrafting Services Requested
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74112, item=194703 }, -- Draconic Treatise on Jewelcrafting
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
                            quest = 29516, -- Keeping the Faire Sparkling
                        },
                    },
                },
            },
        },
    },
}
