local _, Addon = ...


Addon.data.professions.alchemy = {
    skillLineId = 171,
    expansions = {
        -- Dragon Isles
        dragonflight = {
            name = EXPANSION_NAME9,
            skillLineId = 2823,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70504, item=198963, desc='Drops from Decayed mobs' }, -- Decaying Phlegm
                        { quest=70511, item=198964, desc='Drops from Elemental mobs' }, -- Elementious Splinter
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
                        { quest=74935, item=204226, level=70, desc='Drops from Agni Blazehoof' }, -- Blazehoof Ashes
                    },
                },
            },
            quests = {
                {
                    key = 'craft',
                    entries = {
                        { quest=70530 }, -- Examination Week
                        { quest=70531 }, -- Mana Markets
                        { quest=70532 }, -- Aiding the Raiding
                        { quest=70533 }, -- Draught, Oiled Again
                    },
                },
                {
                    key = 'gather',
                    entries = {
                        { quest=66937 }, -- Decaying News
                        { quest=66938 }, -- Mammoth Marrow
                        { quest=66940 }, -- Elixir Experiment
                        { quest=72427 }, -- Animated Infusion
                        { quest=75363, level=70 }, -- Deepflayer Dust [ZC]
                        { quest=75371, level=70 }, -- Fascinating Fungi [ZC]
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
    },
}
