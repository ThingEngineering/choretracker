local _, Addon = ...
local L = Addon.L


Addon.data.delves.midnight = {
    key = 'midnight',
    name = EXPANSION_NAME11,
    -- UiMap ID -> AreaPOIs for Bountiful delves
    zones = {
        -- Eversong Woods
        {
            uiMapId = 2395,
            pois = {
                { active = 8426, inactive = 8425, quest = 0 }, -- Collegiate Calamity
                { active = 8438, inactive = 8437, quest = 0 }, -- The Shadow Enclave
            },
        },
        -- Voidstorm
        {
            uiMapId = 2405,
            pois = {
                { active = 8432, inactive = 8431, quest = 0 }, -- Shadowguard Point
                { active = 8430, inactive = 8429, quest = 0 }, -- Sunkiller Sanctum
            },
        },
        -- Harandar
        {
            uiMapId = 2413,
            pois = {
                { active = 8434, inactive = 8433, quest = 0 }, -- The Grudge Pit
                { active = 8436, inactive = 8435, quest = 0 }, -- The Gulf of Memory
            },
        },
        -- Zul'Aman
        {
            uiMapId = 2437,
            pois = {
                { active = 8444, inactive = 8443, quest = 0 }, -- Atal'Aman
                { active = 8442, inactive = 8441, quest = 0 }, -- Twilight Crypts
            },
        },
    },
}
