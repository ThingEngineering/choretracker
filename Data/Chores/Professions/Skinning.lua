local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionSkinning = {
    key = 'professions',
    order = 109,
    skillLineId = 393,
    texture = C_Spell.GetSpellTexture(8613),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2882,
            drops = {
                {
                    key = 'gather',
                    groupSameItem = true,
                    entries = {
                        { quest=81459, item=224780 }, -- Toughened Tempest Pelt
                        { quest=81460, item=224780 }, -- Toughened Tempest Pelt
                        { quest=81461, item=224780 }, -- Toughened Tempest Pelt
                        { quest=81462, item=224780 }, -- Toughened Tempest Pelt
                        { quest=81463, item=224780 }, -- Toughened Tempest Pelt
                        { quest=81464, item=224781 }, -- Abyssal Fur
                    },
                },
            },
            quests = {
                {
                    key = 'task',
                    skill = 25,
                    entries = {
                        { quest=83097 }, -- Cinder and Storm 
                        { quest=83100 }, -- Cracking the Shell 
                        { quest=82993 }, -- From Shadows 
                        { quest=83098 }, -- Snap and Crackle 
                        { quest=82992 }, -- Stormcharged Goods
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=83734, item=222649 }, -- Algari Treatise on Skinning
                    },
                },
                {
                    key = 'skinSlatefang',
                    minimumLevel = 72,
                    skill = 1,
                    defaultEnabled = true,
                    entries = {
                        { quest=84259, item=219013 }, -- Superb Beast Fang
                    }
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2834,
            drops = {
                {
                    key = 'gather',
                    defaultEnabled = false,
                    groupSameItem = true,
                    entries = {
                        { quest=70381, item=198837 }, -- Curious Hide Scraps
                        { quest=70383, item=198837 }, -- Curious Hide Scraps
                        { quest=70384, item=198837 }, -- Curious Hide Scraps
                        { quest=70385, item=198837 }, -- Curious Hide Scraps
                        { quest=70386, item=198837 }, -- Curious Hide Scraps
                        { quest=70389, item=198841 }, -- Large Sample of Curious Hide
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74930, item=204231, level=70, desc='Faunos' }, -- Kingly Sheepskin Pelt
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    skill = 45,
                    defaultEnabled = false,
                    entries = {
                        { quest=70619 }, -- A Study of Leather
                        { quest=70620 }, -- Scaling Up
                        { quest=72158 }, -- A Dense Delivery
                        { quest=72159 }, -- Scaling Down
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74114, item=201023 }, -- Draconic Treatise on Skinning
                    },
                },
                {
                    key = 'skinMagmaCobra',
                    skill = 1,
                    defaultEnabled = false,
                    entries = {
                        { quest=74235, item=205413 }, -- Obsidian Cobraskin
                    }
                },
                {
                    key = 'skinVerdantGladewarden',
                    skill = 1,
                    defaultEnabled = false,
                    entries = {
                        { quest=78397, item=210456 }, -- Dreaming Antler Fragment
                    }
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
                            quest = 29519, -- Tan My Hide
                        },
                    },
                },
            },
        },
    },
}
