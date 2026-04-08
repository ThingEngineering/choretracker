local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresEvents = {
    key = 'events',
    name = L['section:events'],
    order = 0,
    categories = {
        {
            key = 'special',
            quests = {
                {
                    key = 'turboBoost',
                    minimumLevel = 80,
                    -- requiredQuest = 86204, -- Liberation of Undermine: The House Loses
                    entries = {
                        { quest = 91205 }, -- Ultra Prime Deluxe Turbo-Boost: Powerhouse Challenges
                    },
                },
                {
                    key = 'prepatchDisruptTheCall',
                    minimumLevel = 10,
                    -- requiredQuest = 90768, -- Cult it Out (account?)
                    entries = {
                        { quest = 91795 }, -- Disrupt the Call
                    },
                },
                {
                    key = 'prepatchTwilightsDawn',
                    minimumLevel = 10,
                    -- requiredQuest = 90768, -- Cult it Out (account?)
                    entries = {
                        { quest = 87308 }, -- Twilight's Dawn
                    },
                },
            },
        },
        {
            key = 'holidays2',
            dungeons = {
                {
                    key = 'crownChemicalCo',
                    minimumLevel = 60,
                    requiredEventIds = { 335, 423 },
                    dungeonId = 288,
                },
                {
                    key = 'corenDirebrew',
                    minimumLevel = 60,
                    requiredEventIds = { 372 },
                    dungeonId = 287,
                },
                {
                    key = 'headlessHorseman',
                    minimumLevel = 60,
                    requiredEventIds = { 324, 1405 },
                    dungeonId = 285,
                },
                {
                    key = 'frostLordAhune',
                    minimumLevel = 60,
                    requiredEventIds = { 341 }, -- Midsummer Fire Festival
                    dungeonId = 286,
                },
            },
            quests = {
                {
                    key = 'meanOne',
                    minimumLevel = 30,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 7043 }, -- [A] You're a Mean One...
                        { quest = 6983 }, -- [H] You're a Mean One...
                    }
                },
                {
                    key = 'grumpus',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39651 }, -- Grumpus
                    }
                },
                {
                    key = 'menacingGrumplings',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39649 }, -- Menacing Grumplings
                    }
                },
                {
                    key = 'whatHorriblePresents',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39668 }, -- What Horrible Presents!
                    }
                },
                {
                    key = 'whereAreTheChildren',
                    minimumLevel = 40,
                    requiredEventIds = { 141 }, -- Feast of Winter Veil
                    entries = {
                        { quest = 39648 }, -- Where Are the Children?
                    }
                },
            },
        },
    },
}
