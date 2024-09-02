local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionInscription = {
    key = 'professions',
    order = 105,
    skillLineId = 773,
    texture = C_Spell.GetSpellTexture(45357),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2878,
            drops = {
                {
                    key = 'mob/treasure',
                    entries = {
                        { quest=83264, item=225226 }, -- Striated Inkstone
                        { quest=83262, item=225227 }, -- Wax-Sealed Records
                    },
                },
            },
            quests = {
                {
                    key = 'treatise',
                    entries = {
                        { quest=83730, item=222548 }, -- Algari Treatise on Inscription
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=84129 }, -- Inscription Services Requested
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2828,
            drops = {
                {
                    key = 'mob',
                    defaultEnabled = false,
                    entries = {
                        { quest=70518, item=198971, desc='Djaradin' }, -- Curious Djaradin Rune
                        { quest=70519, item=198972, desc='Dragonkin' }, -- Draconic Glamour
                    },
                },
                {
                    key = 'treasure',
                    defaultEnabled = false,
                    entries = {
                        { quest=66375, item=193904 }, -- Phoenix Feather Quill
                        { quest=66376, item=193905 }, -- Iskaaran Trading Ledger
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74932, item=204229, level=70, desc='Arcantrix' }, -- Glimmering Rune of Arcantrix
                    },
                },
            },
            quests = {
                {
                    key = 'provide',
                    skill = 45,
                    defaultEnabled = false,
                    entries = {
                        { quest=70558 }, -- Disillusioned Illusions
                        { quest=70559 }, -- Quill You Help?
                        { quest=70560 }, -- The Most Powerful Tool: Good Documentation
                        { quest=70561 }, -- A Scribe's Tragedy
                    },
                },
                {
                    key = 'task',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=66943 }, -- Wood for Writing
                        { quest=66944 }, -- Peacock Pigments
                        { quest=66945 }, -- Icy Ink
                        { quest=72438 }, -- Tarasek Intentions
                        { quest=75149, level=70 }, -- Obsidian Essays [ZC]
                        { quest=75573, level=70 }, -- Proclamation Reclamation [ZC]
                        { quest=77889, level=70 }, -- A Fiery Proposal [ED]
                        { quest=77914, level=70 }, -- Burning Runes [ED]
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74105, item=194699 }, -- Draconic Treatise on Inscription
                    },
                },
                {
                    key = 'orders',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=70592 }, -- Inscription Services Requested
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
                            quest = 29515, -- Writing the Future
                            shoppingList = {
                                { 5, 39354 }, -- Light Parchment
                            }
                        },
                    },
                },
            },
        },
    },
}
