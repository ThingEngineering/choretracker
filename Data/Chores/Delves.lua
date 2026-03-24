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
                        { quest=86371, item=252415 }, -- Trovehunter's Bounty [Season 1]
                    },
                },
                {
                    key = 'bountyUse',
                    minimumLevel = 90,
                    entries = {
                        { quest=92887, item=252415 }, -- Trovehunter's Bounty [Season 1]
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
