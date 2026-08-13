local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresDelves = {
    key = 'delves',
    name = L['section:delves'],
    order = 50,
    minimumLevel = 80,
    categories = {
        {
            key = 'midnightDelves',
            quests = {
                {
                    key = 'remnant',
                    minimumLevel = 80,
                    oncePerAccount = true,
                    entries = {
                        { quest=93784, item=262586 }, -- Primeval Arcane Remnant
                    }
                },
                {
                    key = 'bountyGet',
                    minimumLevel = 90,
                    entries = {
                        { quest=86371, item=274374 }, -- Trovehunter's Bounty [Season 2]
                    },
                },
                {
                    key = 'invasion',
                    minimumLevel = 90,
                    entries = {
                        { quest=92887, item=275910 }, -- Scalebound Herald's Flute
                    },
                },
                {
                    key = 'gilded',
                    minimumLevel = 90,
                    entries = {
                        { quest=5000001 },
                    },
                },
            },
        },
    },
}
