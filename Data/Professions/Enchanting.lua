local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionEnchanting = {
    key = 'professions',
    order = 102,
    skillLineId = 333,
    texture = GetSpellTexture(7411),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2825,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70514, item=198967, desc='Arcane' }, -- Primordial Aether
                        { quest=70515, item=198968, desc='Primalist' }, -- Primalist Charm
                    },
                },
                {
                    key = 'treasure',
                    entries = {
                        { quest=66377, item=193900 }, -- Prismatic Focusing Shard
                        { quest=66378, item=193901 }, -- Primal Dust
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74927, item=204224, level=70, desc='Manathema' }, -- Speck of Arcane Awareness
                    },
                },
            },
            quests = {
                {
                    key = 'gather',
                    skill = 25,
                    entries = {
                        { quest=66884 }, -- Fireproof Gear
                        { quest=66900 }, -- Enchanted Relics
                        { quest=66935 }, -- Crystal Quill Pens
                        { quest=72423 }, -- Weathering the Storm
                        { quest=75150, level=70 }, -- Incandescence [ZC]
                        { quest=75865, level=70 }, -- Relic Rustler [ZC]
                        { quest=77910, level=70 }, -- Enchanted Shrubbery [ED]
                        { quest=77937, level=70 }, -- Forbidden Sugar [ED]
                    },
                },
                {
                    key = 'provide',
                    skill = 45,
                    entries = {
                        { quest=72155 }, -- Spread the Enchantment
                        { quest=72172 }, -- Essence, Shards, and Chromatic Dust
                        { quest=72173 }, -- Braced for Enchantment
                        { quest=72175 }, -- A Secpt-acular Time
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74110, item=194702 }, -- Draconic Treatise on Enchanting
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
                            quest = 29510, -- Putting Trash to Good Use
                        },
                    },
                },
            },
        },
    },
}
