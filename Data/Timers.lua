local _, Addon = ...
local L = Addon.L


Addon.data.timers = {
    {
        key = 'communityFeast',
        minimumLevel = 60,
        interval = 90 * 60,
        duration = 15 * 60,
        awakenedMap = 2522, -- Vault of the Incarnates
    },
    {
        key = 'dragonbaneKeep',
        minimumLevel = 60,
        interval = 120 * 60,
        duration = 15 * 60,
        awakenedMap = 2522, -- Vault of the Incarnates
    },
    {
        key = 'researchersUnderFire',
        minimumLevel = 70,
        interval = 60 * 60,
        duration = 25 * 60,
        offset = 30 * 60,
        awakenedMap = 2569, -- Aberrus, the Shadowed Crucible
    },
    {
        key = 'timeRift',
        minimumLevel = 60,
        interval = 60 * 60,
        duration = 15 * 60,
        awakenedMap = 2569, -- Aberrus, the Shadowed Crucible
    },
    {
        key = 'superbloom',
        minimumLevel = 70,
        interval = 60 * 60,
        duration = 15 * 60,
        awakenedMap = 2549, -- Amirdrassil, the Dream's Hope
    },
    {
        key = 'dreamsurge',
        minimumLevel = 70,
        interval = 30 * 60,
        duration = 5 * 60,
        awakenedMap = 2549, -- Amirdrassil, the Dream's Hope
    },
    {
        key = 'bigDig',
        minimumLevel = 70,
        interval = 60 * 60,
        duration = 25 * 60,
        offset = 30 * 60,
    },
}
