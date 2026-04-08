local _, Addon = ...
local L = Addon.L

Addon.data.chores.choresLeveling = {
    key = 'leveling',
    name = L['section:leveling'],
    order = 19,
    minimumLevel = 80,
    categories = {
        {
            key = 'midnight',
            quests = {
                {
                    key = 'delves',
                    minimumLevel = 80,
                    pick = 10,
                    filter = function()
                        return UnitLevel('player') < 90
                    end,
                    entries = {
                        -- Silvermoon City
                        { quest = 93384 }, -- Delver's Call: Collegiate Calamity
                        { quest = 93385 }, -- Delver's Call: The Darkway
                        -- Isle of Quel'Danas
                        { quest = 93386 }, -- Delver's Call: Parhelion Plaza
                        -- Eversong Woods
                        { quest = 93372 }, -- Delver's Call: Shadow Enclave
                        -- Zul'Aman
                        { quest = 93409 }, -- Delver's Call: Atal'Aman
                        { quest = 93410 }, -- Delver's Call: Twilight Crypts
                        -- Harandar
                        { quest = 93421 }, -- Delver's Call: The Grudge Pit
                        { quest = 93416 }, -- Delver's Call: The Gulf of Memory
                        -- Voidstorm
                        { quest = 93428 }, -- Delver's Call: Shadowguard Point
                        { quest = 93427 }, -- Delver's Call: Sunkiller Sanctum
                    },
                },
            }
        },
    },
}
