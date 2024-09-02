local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionTailoring = {
    key = 'professions',
    order = 110,
    skillLineId = 197,
    texture = C_Spell.GetSpellTexture(3908),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2883,
            drops = {
                {
                    key = 'mob/treasure',
                    entries = {
                        { quest=83270, item=225220 }, -- Chitin Needle
                        { quest=83269, item=225221 }, -- Spool of Webweave
                    },
                },
            },
            quests = {
                {
                    key = 'treatise',
                    entries = {
                        { quest=83735, item=222547 }, -- Algari Treatise on Tailoring
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=84132 }, -- Tailoring Services Requested
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2831,
            drops = {
                {
                    key = 'mob',
                    defaultEnabled = false,
                    entries = {
                        { quest=70524, item=198977, desc='Centaur' }, -- Ohn'arhan Weave
                        { quest=70525, item=198978, desc='Gnoll' }, -- Stupidly Effective Stitchery
                    },
                },
                {
                    key = 'treasure',
                    defaultEnabled = false,
                    entries = {
                        { quest=66386, item=193898 }, -- Umbral Bone Needle
                        { quest=66387, item=193899 }, -- Primalweave Spindle
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74931, item=204225, level=70, desc='Gareed' }, -- Perfect Windfeather
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    skill = 50,
                    defaultEnabled = false,
                    entries = {
                        { quest=70572 }, -- The Cold Does Bother Them, Actually
                        { quest=70582 }, -- Weave Well Enough Alone
                        { quest=70586 }, -- Sew Many Cooks
                        { quest=70587 }, -- A Knapsack Problem
                    },
                },
                {
                    key = 'task',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=66899 }, -- Fuzzy Legs
                        { quest=66952 }, -- The Gnoll's Clothes
                        { quest=66953 }, -- All Things Fluffy
                        { quest=72410 }, -- Pincers and Needles
                        { quest=75407, level=70 }, -- Silk Scavenging [ZC]
                        { quest=75600, level=70 }, -- Silk's Silk [ZC]
                        { quest=77947, level=70 }, -- Primalist Fashion [ED]
                        { quest=77949, level=70 }, -- Fashion Feathers [ED]
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74115, item=194698 }, -- Draconic Treatise on Tailoring
                    },
                },
                {
                    key = 'orders',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=70595 }, -- Tailoring Services Requested
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
                            quest = 29520, -- Banners, Banners Everywhere!
                            shoppingList = {
                                { 1, 2604 }, -- Red Dye
                                { 1, 6260 }, -- Blue Dye
                                { 1, 2320 }, -- Coarse Thread
                            }
                        },
                    },
                },
            },
        },
    },
}
