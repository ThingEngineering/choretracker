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
            areaPoiIds = {
                8936, -- The Looming Mutagenitor
                8937, -- Siege at the Whispering Marsh
                8938, -- The Broodmother's Nest
                8939, -- Mlurkkr Massacre
                8940, -- The Malformed Leviathan
            },
        },
    },
}
