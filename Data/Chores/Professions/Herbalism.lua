local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionHerbalism = {
    key = 'professions',
    order = 104,
    skillLineId = 182,
    texture = C_Spell.GetSpellTexture(2366),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2877,
            drops = {
                {
                    key = 'gather',
                    groupSameItem = true,
                    entries = {
                        { quest=81416, item=224264 }, -- Deepgrove Rose Petal
                        { quest=81417, item=224264 }, -- Deepgrove Rose Petal
                        { quest=81418, item=224264 }, -- Deepgrove Rose Petal
                        { quest=81419, item=224264 }, -- Deepgrove Rose Petal
                        { quest=81420, item=224264 }, -- Deepgrove Rose Petal
                        { quest=81421, item=224265 }, -- Deepgrove Rose
                    },
                },
            },
            quests = {
                {
                    key = 'task',
                    skill = 25,
                    entries = {
                        { quest=82970 }, -- A Bloom and A Blossom
                        { quest=82962 }, -- A Handful of Luredrops
                        { quest=82965 }, -- Light and Shadow
                        { quest=82958 }, -- Little Blessings
                        { quest=82916 }, -- When Fungi Bloom
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=83729, item=222552 }, -- Algari Treatise on Herbalism
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2832,
            drops = {
                {
                    key = 'gather',
                    defaultEnabled = false,
                    groupSameItem = true,
                    entries = {
                        { quest=71857, item=200677 }, -- Dreambloom Petal
                        { quest=71858, item=200677 }, -- Dreambloom Petal
                        { quest=71859, item=200677 }, -- Dreambloom Petal
                        { quest=71860, item=200677 }, -- Dreambloom Petal
                        { quest=71861, item=200677 }, -- Dreambloom Petal
                        { quest=71864, item=200678 }, -- Dreambloom
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74933, item=204228, level=70, desc='Kangalo' }, -- Undigested Hochenblume Petal
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    skill = 45,
                    defaultEnabled = false,
                    entries = {
                        { quest=70613 }, -- Get Their Bark Before They Bite
                        { quest=70614 }, -- Bubble Craze
                        { quest=70615 }, -- The Case of the Missing Herbs
                        { quest=70616 }, -- How Many??
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74107, item=194704 }, -- Draconic Treatise on Herbalism
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
                            quest = 29514, -- Herbs for Healing
                        },
                    },
                },
            },
        },
    },
}
