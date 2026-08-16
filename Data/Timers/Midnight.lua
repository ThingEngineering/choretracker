local _, Addon = ...
local L = Addon.L


Addon.data.timers.midnight = {
    key = 'midnight',
    name = EXPANSION_NAME11,
    timers = {
        {
            key = 'curseSurge',
            minimumLevel = 90,
            interval = 45 * 60,
            duration = 5 * 60,
            offset = 0,
            uiMapId = 2512, -- The Coiled Isle
            areaPois = {
                -- [areaPoiId] = { normalizedX, normalizedY, absoluteZ }
                [8936] = { 0.267, 0.648, 199.186 }, -- The Looming Mutagenitor
                [8937] = { 0.676, 0.778, 4.39461 }, -- Siege at the Whispering Marsh
                [8938] = { 0.452, 0.286, 148.695 }, -- The Broodmother's Nest
                [8939] = { 0.709, 0.319, 8.43455 }, -- Mlurkkr Massacre
                [8940] = { 0.469, 0.622, 176.339 }, -- The Malformed Leviathan
            },
        },
    },
}
