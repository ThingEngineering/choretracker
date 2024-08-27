local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule(
    'Timers',
    {
        timers = {},
    },
    'AceTimer-3.0'
)


function Module:OnEnable()
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

    for _, category in pairs(Addon.data.timers) do
        for _, event in ipairs(category.timers) do
            local lastStart = weeklyReset + (event.offset or 0)
            local lastEnd = lastStart + event.duration
            local nextStart = lastStart - event.interval
            local nextEnd = lastEnd - event.interval

            while nextEnd > now do
                lastStart = nextStart
                lastEnd = nextEnd
                nextStart = nextStart - event.interval
                nextEnd = nextEnd - event.interval
            end

            self.timers[event.key] = {
                startsAt = lastStart,
                endsAt = lastEnd,
            }
        end
    end

    self:SendMessage('ChoreTracker_Data_Updated', 'timers')
end
