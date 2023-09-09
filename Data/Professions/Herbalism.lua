local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionHerbalism = {
    key = 'professions',
    order = 104,
    skillLineId = 182,
    texture = GetSpellTexture(2366),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2832,
            drops = {
                {
                    key = 'gather',
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
                    key = 'gather',
                    skill = 45,
                    entries = {
                        { quest=70613 }, -- Get Their Bark Before They Bite
                        { quest=70614 }, -- Bubble Craze
                        { quest=70615 }, -- The Case of the Missing Herbs
                        { quest=70616 }, -- How Many??
                    },
                },
                {
                    key = 'treatise',
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
