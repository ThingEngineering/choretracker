local _, Addon = ...
local L = Addon.L


Addon.data.timers.warWithin = {
    key = 'warWithin',
    name = EXPANSION_NAME10,
    timers = {
        {
            key = 'theaterTroupe',
            minimumLevel = 70,
            interval = 60 * 60,
            duration = 10 * 60,
        },
    },
}
