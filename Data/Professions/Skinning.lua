local _, Addon = ...
local L = Addon.L


Addon.data.professionSkinning = {
    key = 'professions',
    order = 109,
    skillLineId = 393,
    texture = GetSpellTexture(8613),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2834,
            drops = {
                {
                    key = 'gather',
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
                    key = 'gather',
                    skill = 45,
                    entries = {
                        { quest=70619 }, -- A Study of Leather
                        { quest=70620 }, -- Scaling Up
                        { quest=72158 }, -- A Dense Delivery
                        { quest=72159 }, -- Scaling Down
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74114, item=201023 }, -- Draconic Treatise on Skinning
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
                            quest = 29519, -- Tan My Hide
                        },
                    },
                },
            },
        },
    },
}
