local _, Addon = ...
local L = Addon.L


Addon.data.timers.dragonflight = {
    key = 'dragonflight',
    name = EXPANSION_NAME9,
    timers = {
        {
            key = 'communityFeast',
            minimumLevel = 60,
            interval = 90 * 60,
            duration = 15 * 60,
        },
        {
            key = 'dragonbaneKeep',
            minimumLevel = 60,
            interval = 120 * 60,
            duration = 15 * 60,
        },
        {
            key = 'researchersUnderFire',
            minimumLevel = 70,
            interval = 60 * 60,
            duration = 25 * 60,
            offset = 30 * 60,
        },
        {
            key = 'timeRift',
            minimumLevel = 60,
            interval = 60 * 60,
            duration = 15 * 60,
        },
        {
            key = 'superbloom',
            minimumLevel = 70,
            interval = 60 * 60,
            duration = 15 * 60,
        },
        {
            key = 'dreamsurge',
            minimumLevel = 70,
            interval = 30 * 60,
            duration = 5 * 60,
        },
        {
            key = 'bigDig',
            minimumLevel = 70,
            interval = 60 * 60,
            duration = 25 * 60,
            offset = 30 * 60,
        },
    },
}
