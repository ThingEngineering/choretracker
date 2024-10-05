local _, Addon = ...
local L = Addon.L


Addon.data.chores.choresHallowfallFishingDerby = {
    key = 'hallowfallFishingDerby',
    name = L['section:hallowfallFishingDerby'],
    order = 123,
    defaultEnabled = false,
    filter = function()
        local timeInfo = C_DateAndTime.GetCalendarTimeFromEpoch(time() * 1000000)
        return timeInfo ~= nil and timeInfo.weekday == 7
    end,
    categories = {
        {
            key = 'event',
            quests = {
                {
                    key = 'derby',
                    entries = {
                        { quest = 82778 },
                        { quest = 83529 },
                        { quest = 83530 },
                        { quest = 83531 },
                        { quest = 83532 },
                    }
                },
            },
        },
        {
            key = 'fish',
            drops = {
                {
                    key = 'fish',
                    entries = {
                        -- Common
                        { quest = 82920, item=220137 }, -- Bismuth Bitterling
                        { quest = 82918, item=220135 }, -- Bloody Perch
                        { quest = 82919, item=220136 }, -- Crystalline Sturgeon
                        { quest = 82947, item = 220134 }, -- Dilly-Dally Dace
                        -- Uncommon
                        { quest = 82928, item=220145 }, -- Arathor Hammerfish
                        { quest = 82926, item=220143 }, -- Dornish Pike
                        { quest = 82923, item=222533 }, -- Goldengill Trout
                        { quest = 82930, item=220147 }, -- Kaheti Slum Shark
                        { quest = 82921, item=220138 }, -- Nibbling Minnow
                        { quest = 82931, item=220148 }, -- Pale Huskfish
                        { quest = 82925, item=220142 }, -- Quiet River Bass
                        { quest = 82927, item=220144 }, -- Roaring Anglerseeker
                        { quest = 82924, item=220141 }, -- Specular Rainbowfish
                        { quest = 82922, item=220139 }, -- Whispering Stargazer
                        -- Rare
                        { quest = 82936, item=220153 }, -- Awoken Coelacanth
                        { quest = 82935, item=220152 }, -- Cursed Ghoulfish
                        { quest = 82934, item=220151 }, -- Queen's Lurefish
                        { quest = 82929, item=220146 }, -- Regal Dottyback
                        { quest = 82932, item=220149 }, -- Sanguine Dogfish
                        { quest = 82933, item=220150 }, -- Spiked Sea Raven
                    },
                },
            },
        },
    },
}
