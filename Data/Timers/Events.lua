local _, Addon = ...
local L = Addon.L


Addon.data.timers.events = {
    key = 'events',
    name = L['section:events'],
    timers = {
        {
            key = 'brewfestBanquet',
            minimumLevel = 10,
            interval = 60 * 60,
            duration = 10 * 60,
            offset = 0,
            requiredEventIds = { 372 },
        },
    },
}
