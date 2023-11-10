local _, Addon = ...
local L = Addon.L


Addon.data.timers = {
    {
        key = 'communityFeast',
        interval = 90 * 60,
        duration = 15 * 60,
    },
    {
        key = 'dragonbaneKeep',
        interval = 120 * 60,
        duration = 15 * 60,
    },
    {
        key = 'researchersUnderFire',
        interval = 60 * 60,
        duration = 25 * 60,
        offset = 30 * 60,
    },
    {
        key = 'superbloom',
        interval = 60 * 60,
        duration = 15 * 60,
    },
    {
        key = 'timeRift',
        interval = 60 * 60,
        duration = 15 * 60,
    },
}
