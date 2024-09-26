local _, Addon = ...
local L = Addon.L


Addon.data.delves.warWithin = {
    key = 'warWithin',
    name = EXPANSION_NAME10,
    -- UiMap ID -> AreaPOIs for Bountiful delves
    zones = {
        -- Isle of Dorn
        {
            uiMapId = 2248,
            pois = {
                { active = 7779, inactive = 7864, quest = 82939 }, -- Fungal Folly
                { active = 7781, inactive = 7865, quest = 82941 }, -- Kriegval's Rest
                { active = 7787, inactive = 7863, quest = 82944 }, -- Earthcrawl Mines
            },
        },
        -- The Ringing Deeps
        {
            uiMapId = 2214,
            pois = {
                { active = 7782, inactive = 7866, quest = 82945 }, -- The Waterworks
                { active = 7788, inactive = 7867, quest = 82938 }, -- The Dread Pit
            },
        },
        -- Hallowfall
        {
            uiMapId = 2215,
            pois = {
                { active = 7780, inactive = 7869, quest = 82940 }, -- Mycomancer Cavern
                { active = 7783, inactive = 7870, quest = 82937 }, -- The Sinkhole
                { active = 7785, inactive = 7868, quest = 82777 }, -- Nightfall Sanctum
                { active = 7789, inactive = 7871, quest = 78508 }, -- Skittering Breach
            },
        },
        -- Azj-Kahet
        {
            uiMapId = 2255,
            pois = {
                { active = 7784, inactive = 7873, quest = 82776 }, -- Tak-Rethan Abyss
                { active = 7786, inactive = 7872, quest = 82943 }, -- The Underkeep
                { active = 7790, inactive = 7874, quest = 82942 }, -- The Spiral Weave
            },
        },
    },
}
