local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionEnchanting = {
    key = 'professions',
    order = 102,
    skillLineId = 333,
    texture = C_Spell.GetSpellTexture(7411),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2874,
            drops = {
                {
                    key = 'gather',
                    groupSameItem = true,
                    entries = {
                        { quest=84290, item=227659 }, -- Fleeting Arcane Manifestation
                        { quest=84291, item=227659 }, -- Fleeting Arcane Manifestation
                        { quest=84292, item=227659 }, -- Fleeting Arcane Manifestation
                        { quest=84293, item=227659 }, -- Fleeting Arcane Manifestation
                        { quest=84294, item=227659 }, -- Fleeting Arcane Manifestation
                        { quest=84295, item=227661 }, -- Gleaming Telluric Crystal
                    },
                },
                {
                    key = 'mob/treasure',
                    entries = {
                        { quest=83259, item=225230 }, -- Crystalline Repository
                        { quest=83258, item=225231 }, -- Powdered Fulgurance
                    },
                },
            },
            quests = {
                {
                    key = 'task',
                    skill = 20,
                    entries = {
                        { quest=84084 }, -- Just a Pinch
                        { quest=84085 }, -- The Power of Potential
                        { quest=84086 }, -- A Rare Necessity
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=83727, item=222550 }, -- Algari Treatise on Enchanting
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2825,
            drops = {
                {
                    key = 'mob',
                    defaultEnabled = false,
                    entries = {
                        { quest=70514, item=198967, desc='Arcane' }, -- Primordial Aether
                        { quest=70515, item=198968, desc='Primalist' }, -- Primalist Charm
                    },
                },
                {
                    key = 'treasure',
                    defaultEnabled = false,
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
                    key = 'provide',
                    skill = 45,
                    defaultEnabled = false,
                    entries = {
                        { quest=72155 }, -- Spread the Enchantment
                        { quest=72172 }, -- Essence, Shards, and Chromatic Dust
                        { quest=72173 }, -- Braced for Enchantment
                        { quest=72175 }, -- A Secpt-acular Time
                    },
                },
                {
                    key = 'task',
                    skill = 25,
                    defaultEnabled = false,
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
                    key = 'treatise',
                    defaultEnabled = false,
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
