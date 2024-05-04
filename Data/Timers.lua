local _, Addon = ...
local L = Addon.L


Addon.data.timers = {
    {
        key = 'communityFeast',
        minimumLevel = 60,
        interval = 90 * 60,
        duration = 15 * 60,
        awakenedQuest = 80385, -- Last Hurrah: Dragon Isles
    },
    {
        key = 'dragonbaneKeep',
        minimumLevel = 60,
        interval = 120 * 60,
        duration = 15 * 60,
        awakenedQuest = 80385, -- Last Hurrah: Dragon Isles
    },
    {
        key = 'researchersUnderFire',
        minimumLevel = 70,
        interval = 60 * 60,
        duration = 25 * 60,
        offset = 30 * 60,
        awakenedQuest = 80386, -- Last Hurrah: Zaralek Caverns and Time Rifts
    },
    {
        key = 'timeRift',
        minimumLevel = 60,
        interval = 60 * 60,
        duration = 15 * 60,
        awakenedQuest = 80386, -- Last Hurrah: Zaralek Caverns and Time Rifts
    },
    {
        key = 'superbloom',
        minimumLevel = 70,
        interval = 60 * 60,
        duration = 15 * 60,
        awakenedQuest = 80388, -- Last Hurrah: Emerald Dream
    },
    {
        key = 'dreamsurge',
        minimumLevel = 70,
        interval = 30 * 60,
        duration = 5 * 60,
        awakenedQuest = 80388, -- Last Hurrah: Emerald Dream
    },
}
