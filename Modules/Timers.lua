local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Timers', 'AceTimer-3.0')


local EVENTS = {
    communityFeast = { 90 * 60, 15 * 60 },
    dragonbaneKeep = { 120 * 60, 15 * 60 },
    researchersUnderFire = { 60 * 60, 25 * 60, 30 * 60 },
}

function Module:OnEnable()
    self.timers = {}
end

function Module:OnEnteringWorld()
    -- Schedule our timer to run every minute on the minute. We can't just start a timer
    -- with the delay we want because the first timer we start will run fast (???)
    local wait = 60 - (time() % 60)
    C_Timer.After(0, function()
        C_Timer.After(wait, function()
            self:StartTimer()
        end)
    end)

    self:UpdateTimers()
end

function Module:StartTimer()
    self:ScheduleRepeatingTimer('UpdateTimers', 60)
    self:UpdateTimers()
end

function Module:UpdateTimers()
    wipe(self.timers)

    local now = time()
    local weeklyReset = now + C_DateAndTime.GetSecondsUntilWeeklyReset() + 1

    for key, event in pairs(EVENTS) do
        local interval, duration, offset = unpack(event)

        local lastStart = weeklyReset + (offset or 0)
        local lastEnd = lastStart + duration
        local nextStart = weeklyReset - interval
        local nextEnd = lastEnd - interval

        while nextEnd > now do
            lastStart = nextStart
            lastEnd = nextEnd
            nextStart = nextStart - interval
            nextEnd = nextEnd - interval
        end

        self.timers[key] = {
            startsAt = lastStart,
            endsAt = lastEnd,
        }
    end

    self:SendMessage('ChoreTracker_TimersUpdated')
end
