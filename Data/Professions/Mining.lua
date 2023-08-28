local _, Addon = ...


Addon.data.professions.mining = {
    skillLineId = 186,
    texture = GetSpellTexture(2575),
    expansions = {
        -- Dragon Isles
        dragonflight = {
            name = EXPANSION_NAME9,
            skillLineId = 2833,
            drops = {
                {
                    key = 'gather',
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
                    key = 'gather',
                    entries = {
                        { quest=70617 }, -- All Mine, Mine, Mine
                        { quest=70618 }, -- The Call of the Forge
                        { quest=72156 }, -- A Fiery Flight
                        { quest=72157 }, -- The Weight of Earth
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74106, item=194708 }, -- Draconic Treatise on Mining
                    },
                },
            },
        },
    },
}
