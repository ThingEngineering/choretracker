local _, Addon = ...
local L = Addon.L


Addon.data.professionInscription = {
    order = 105,
    skillLineId = 773,
    texture = GetSpellTexture(45357),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2828,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70518, item=198971, desc='Djaradin' }, -- Curious Djaradin Rune
                        { quest=70519, item=198972, desc='Dragonkin' }, -- Draconic Glamour
                    },
                },
                {
                    key = 'treasure',
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
                    key = 'craft',
                    entries = {
                        { quest=70558 }, -- Disillusioned Illusions
                        { quest=70559 }, -- Quill You Help?
                        { quest=70560 }, -- The Most Powerful Tool: Good Documentation
                        { quest=70561 }, -- A Scribe's Tragedy
                    },
                },
                {
                    key = 'gather',
                    entries = {
                        { quest=66943 }, -- Wood for Writing
                        { quest=66944 }, -- Peacock Pigments
                        { quest=66945 }, -- Icy Ink
                        { quest=72438 }, -- Tarasek Intentions
                        { quest=75149, level=70 }, -- Obsidian Essays [ZC]
                        { quest=75573, level=70 }, -- Proclamation Reclamation [ZC]
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=70592 }, -- Inscription Services Requested
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74105, item=194699 }, -- Draconic Treatise on Inscription
                    },
                },
            },
        },
        {
            key = 'event',
            name = L['category:event'],
            requiredEventId = 479, -- Darkmoon Faire
            quests = {
                {
                    key = 'darkmoonFaire',
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
