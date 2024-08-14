local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionAlchemy = {
    key = 'professions',
    order = 100,
    skillLineId = 171,
    texture = C_Spell.GetSpellTexture(2259),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2823,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70504, item=198963, desc='Decayed' }, -- Decaying Phlegm
                        { quest=70511, item=198964, desc='Elemental' }, -- Elementious Splinter
                    },
                },
                {
                    key = 'treasure',
                    entries = {
                        { quest=66373, item=193891 }, -- Experimental Substance
                        { quest=66374, item=193897 }, -- Reawakened Catalyst
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74935, item=204226, level=70, desc='Agni Blazehoof' }, -- Blazehoof Ashes
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    skill = 50,
                    entries = {
                        { quest=70530 }, -- Examination Week
                        { quest=70531 }, -- Mana Markets
                        { quest=70532 }, -- Aiding the Raiding
                        { quest=70533 }, -- Draught, Oiled Again
                    },
                },
                {
                    key = 'task',
                    skill = 25,
                    entries = {
                        { quest=66937 }, -- Decaying News
                        { quest=66938 }, -- Mammoth Marrow
                        { quest=66940 }, -- Elixir Experiment
                        { quest=72427 }, -- Animated Infusion
                        { quest=75363, level=70 }, -- Deepflayer Dust [ZC]
                        { quest=75371, level=70 }, -- Fascinating Fungi [ZC]
                        { quest=77932, level=70 }, -- Warmth of Life [ED]
                        { quest=77933, level=70 }, -- Bubbling Discoveries [ED]
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74108, item=194697 }, -- Draconic Treatise on Alchemy
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
                            quest = 29506, -- A Fizzy Fusion
                            shoppingList = {
                                { 5, 1645 }, -- Moonberry Juice
                            }
                        },
                    },
                },
            },
        },
    },
}
