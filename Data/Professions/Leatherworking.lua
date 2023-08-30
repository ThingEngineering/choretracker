local _, Addon = ...


Addon.data.professions.leatherworking = {
    skillLineId = 165,
    texture = GetSpellTexture(2108),
    categories = {
        -- Dragon Isles
        dragonflight = {
            name = EXPANSION_NAME9,
            skillLineId = 2830,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70522, item=198975, desc='Proto-Drake' }, -- Ossified Hide
                        { quest=70523, item=198976, desc='Slyvern & Vorquin' }, -- Exceedingly Soft Skin
                    },
                },
                {
                    key = 'treasure',
                    entries = {
                        { quest=66384, item=193910 }, -- Molted Dragon Scales
                        { quest=66385, item=193913 }, -- Preserved Animal Parts
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74928, item=204232, level=70, desc='Snarfang' }, -- Slyvern Alpha Claw
                    },
                },
            },
            quests = {
                {
                    key = 'craft',
                    entries = {
                        { quest=70567 }, -- When You Give Bakar a Bone
                        { quest=70568 }, -- Tipping the Scales
                        { quest=70569 }, -- For Tristket, a Task Kit
                        { quest=70571 }, -- Drums Here!
                    },
                },
                {
                    key = 'gather',
                    entries = {
                        { quest=66363 }, -- Basilisk Bucklers
                        { quest=66364 }, -- To Fly a Kite
                        { quest=66951 }, -- Population Control
                        { quest=72407 }, -- Soaked in Success
                        { quest=75354, level=70 }, -- Mycelium Mastery [ZC]
                        { quest=75368, level=70 }, -- Stones and Scales [ZC]
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=70594 }, -- Leatherworking Services Requested
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74113, item=194700 }, -- Draconic Treatise on Leatherworking
                    },
                },
            },
        },
    },
}
