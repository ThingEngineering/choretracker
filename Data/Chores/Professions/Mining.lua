local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionMining = {
    key = 'professions',
    order = 108,
    skillLineId = 186,
    texture = C_Spell.GetSpellTexture(2575),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2881,
            drops = {
                {
                    key = 'gather',
                    groupSameItem = true,
                    entries = {
                        { quest=83054, item=224583 }, -- Slab of Slate
                        { quest=83053, item=224583 }, -- Slab of Slate
                        { quest=83052, item=224583 }, -- Slab of Slate
                        { quest=83051, item=224583 }, -- Slab of Slate
                        { quest=83050, item=224583 }, -- Slab of Slate
                        { quest=83049, item=224584 }, -- Erosion Polished Slate
                    },
                },
            },
            quests = {
                {
                    key = 'task',
                    skill = 25,
                    entries = {
                        { quest=83103 }, -- Acquiring Aqirite
                        { quest=83102 }, -- Bismuth is Business
                        { quest=83104 }, -- Identifying Ironclaw
                        { quest=83105 }, -- Rush-order Requisition
                        { quest=83106 }, -- Null Pebble Excavation
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=83733, item=222553 }, -- Algari Treatise on Mining
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2833,
            drops = {
                {
                    key = 'gather',
                    defaultEnabled = false,
                    groupSameItem = true,
                    entries = {
                        { quest=72160, item=201300 }, -- Iridescent Ore Fragments
                        { quest=72161, item=201300 }, -- Iridescent Ore Fragments
                        { quest=72162, item=201300 }, -- Iridescent Ore Fragments
                        { quest=72163, item=201300 }, -- Iridescent Ore Fragments
                        { quest=72164, item=201300 }, -- Iridescent Ore Fragments
                        { quest=72165, item=201301 }, -- Iridescent Ore
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74926, item=204233, level=70, desc='Tectonus' }, -- 
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    skill = 45,
                    defaultEnabled = false,
                    entries = {
                        { quest=70617 }, -- All Mine, Mine, Mine
                        { quest=70618 }, -- The Call of the Forge
                        { quest=72156 }, -- A Fiery Flight
                        { quest=72157 }, -- The Weight of Earth
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74106, item=194708 }, -- Draconic Treatise on Mining
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
                            quest = 29518, -- Rearm, Reuse, Recycle
                        },
                    },
                },
            },
        },
    },
}
