local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Display', 'AceHook-3.0')

local QuestsModule
local TimersModule

local AceGUI = LibStub('AceGUI-3.0')
local LSM = LibStub('LibSharedMedia-3.0')

BINDING_HEADER_CHORETRACKER = addonName
BINDING_NAME_CHORETRACKER_TOGGLE = Addon.L['key_binding:toggle']

local CC_GetDayEvent = C_Calendar.GetDayEvent
local CC_GetNumDayEvents = C_Calendar.GetNumDayEvents
local CDAT_CompareCalendarTime = C_DateAndTime.CompareCalendarTime
local CDAT_GetCalendarTimeFromEpoch = C_DateAndTime.GetCalendarTimeFromEpoch
local CDAT_GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
local CDAT_GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset

local STATUS_COLOR = {
    [0] = '|cFFFF2222',
    [1] = '|cFFFFFF00',
    [2] = '|cFF00FF00',
}
local STATUS_ICON = {
    [0] = '|TInterface\\Addons\\ChoreTracker\\Assets\\status_0:0|t',
    [1] = '|TInterface\\Addons\\ChoreTracker\\Assets\\status_1.tga:0|t',
    [2] = '|TInterface\\Addons\\ChoreTracker\\Assets\\status_2.tga:0|t',
}

function Module:OnEnable()
    QuestsModule = Addon:GetModule('Quests')
    TimersModule = Addon:GetModule('Timers')

    if not IsAddOnLoaded('Blizzard_Calendar') then
        UIParentLoadAddOn('Blizzard_Calendar')
    end

    self.dontShow = false
    self.enabledTimers = {}
    self.itemCache = {}
    self.itemRequested = {}
    self.sectionFrames = {}

    Addon.db.RegisterCallback(self, 'OnProfileChanged', 'ConfigChanged')
    Addon.db.RegisterCallback(self, 'OnProfileCopied', 'ConfigChanged')
    Addon.db.RegisterCallback(self, 'OnProfileReset', 'ConfigChanged')

    self:HookScript(CalendarFrame, 'OnHide', 'ResetCalendar')

    self:RegisterMessage('ChoreTracker_Config_Changed', 'ConfigChanged')
    self:RegisterBucketMessage({ 'ChoreTracker_Data_Updated' }, 0.5, 'Redraw')

    self:RegisterBucketEvent(
        { 'ZONE_CHANGED', 'ZONE_CHANGED_INDOORS', 'ZONE_CHANGED_NEW_AREA' },
        1,
        'UpdateZone'
    )
    self:RegisterBucketEvent({
        'CALENDAR_UPDATE_EVENT_LIST',
        'PLAYER_LEVEL_UP',
    }, 1, 'ConfigChanged')
    self:RegisterBucketEvent({ 'ITEM_DATA_LOAD_RESULT' }, 1, 'ItemsLoaded')

    self:CreateMainFrame()
    self:UpdateShown()
    self:Redraw()
end

function Module:OnEnteringWorld()
    self:ResetCalendar()
    self:UpdateZone()
end

function Module:GetLocalTime()
    return CDAT_GetCalendarTimeFromEpoch(GetServerTime() * 1000000)
end

function Module:ResetCalendar()
    local now = CDAT_GetCurrentCalendarTime()
    C_Calendar.SetAbsMonth(now.month, now.year)
end

function Module:UpdateZone()
    if IsInInstance() then
        self.dontShow = true
        self:UpdateShown()
    else
        self.dontShow = false
        self:UpdateShown()
    end
end

function Module:CreateMainFrame()
    local optionsModule = Addon:GetModule('Options')

    local frame = AceGUI:Create('ChoreFrame')
    frame:SetOptionsFrame(optionsModule.optionsFrame)
    frame:SetStatusTable(Addon.db.profile.window)

    self.frame = frame

    local scrollFrame = AceGUI:Create('ScrollFrame')
    scrollFrame:SetLayout('FancyList')
    scrollFrame:SetFullHeight(true)
    scrollFrame:SetFullWidth(true)
    
    scrollFrame.content.paddingX = 5
    scrollFrame.content.paddingY = 5
    scrollFrame.content.spacing = 4

    self.scrollFrame = scrollFrame

    frame:AddChild(scrollFrame)
end

function Module:UpdateShown()
    if Addon.db.profile.desiredShown == true and self.dontShow == false then
        self.frame:Show()
    else
        self.frame:Hide()
    end
end

function Module:SetDesiredShown(shown)
    Addon.db.profile.desiredShown = shown
    self:UpdateShown()
end

function Module:ToggleShown()
    if self.dontShow == false then
        self:SetDesiredShown(not Addon.db.profile.desiredShown)
    end
end

function Module:ItemsLoaded(data)
    local weCare = false
    for itemId, _ in pairs(data) do
        if self.itemRequested[itemId] == true then
            weCare = true
            break
        end
    end

    if weCare then
        self:Redraw()
    end
end

function Module:ConfigChanged()
    self.font = LSM:Fetch('font', Addon.db.profile.general.text.font)

    if self.sortedSections == nil then
        self.sortedSections = {}
        for sectionKey, sectionData in pairs(Addon.data.chores) do
            table.insert(self.sortedSections, { sectionKey, sectionData })
        end
        table.sort(self.sortedSections, function(a, b) return a[2].order < b[2].order end)
    end

    self.activeEvents = self.activeEvents or {}

    -- Check which events are active if the calendar is set to the correct year/month
    local now = self:GetLocalTime()
    local calendar = C_Calendar.GetMonthInfo(0)
    if now.year == calendar.year and now.month == calendar.month then
        local activeEvents = {}
        for i = 1, CC_GetNumDayEvents(0, now.monthDay) do
            local event = CC_GetDayEvent(0, now.monthDay, i)
            if CDAT_CompareCalendarTime(event.startTime, now) >= 0 and
                CDAT_CompareCalendarTime(event.endTime, now) < 0
            then
                activeEvents[event.eventID] = true
            end
        end
        self.activeEvents = activeEvents
    end

    local playerLevel = UnitLevel('player')

    -- Events
    self.sections = {}
    for _, sectionTemp in ipairs(self.sortedSections) do
        local sectionKey, sectionData = unpack(sectionTemp)
        if
            (sectionData.skillLineId == nil or QuestsModule.skillLines[sectionData.skillLineId] ~= nil) and
            (sectionData.minimumLevel == nil or playerLevel >= sectionData.minimumLevel)
        then
            local header = ''
            if sectionData.texture then
                header = header .. '|T' .. sectionData.texture .. ':0|t '
            end

            header = header .. '|cFFFFFFFF'
            if sectionData.skillLineId ~= nil then
                local profInfo = C_TradeSkillUI.GetProfessionInfoBySkillLineID(sectionData.skillLineId)
                header = header .. profInfo.professionName
            else
                header = header .. sectionData.name
            end
            header = header .. '|r'

            local section = {
                key = sectionKey,
                header = header,
                completed = 0,
                total = 0,
                chores = {},
                entries = {},
            }

            for _, catData in ipairs(sectionData.categories) do
                if catData.skillLineId == nil or QuestsModule.skillLines[catData.skillLineId] ~= nil then
                    for _, typeKey in ipairs({ 'quests', 'drops' }) do
                        for _, choreData in ipairs(catData[typeKey] or {}) do
                            local choreEnabled = Addon.db.profile.chores[sectionKey][catData.key][typeKey]
                            [choreData.key]
                            if choreEnabled == true and
                                (
                                    choreData.requiredEventIds == nil or
                                    self:AnyActive(self.activeEvents, choreData.requiredEventIds)
                                ) and
                                (
                                    choreData.minimumLevel == nil or
                                    playerLevel >= choreData.minimumLevel
                                ) and
                                (
                                    choreData.skill == nil or
                                    QuestsModule.skillLines[catData.skillLineId] >= choreData.skill
                                )
                            then
                                section.total = section.total + 1
                                table.insert(section.chores, {
                                    data = choreData,
                                    translated = L
                                        ['chore:' .. sectionData.key .. ':' .. catData.key .. ':' .. typeKey .. ':' .. choreData.key],
                                    typeKey = typeKey,
                                })
                            end
                        end
                    end
                end
            end

            if section.total > 0 then
                table.insert(self.sections, section)
            end
        end
    end
    
    -- Timers
    wipe(self.enabledTimers)
    for _, timerData in ipairs(Addon.data.timers) do
        if Addon.db.profile.timers[timerData.key] == true then
            table.insert(self.enabledTimers, timerData)
        end
    end

    self:Redraw()
end

function Module:AnyActive(activeEvents, eventIds)
    for _, eventId in ipairs(eventIds) do
        if activeEvents[eventId] == true then
            return true
        end
    end
    return false
end

function Module:Redraw(changed)
    if self.sections == nil then
        self:ConfigChanged()
        return
    end

    -- local started = debugprofilestop()

    local newChildren = {}
    local seenFrames = {}

    -- Timers
    if #self.enabledTimers > 0 then
        local timerFrame = self:GetSectionFrame('timers')

        if changed == nil or changed.timers ~= nil then
            timerFrame:ReleaseChildren()

            local now = time()
            for _, timerData in ipairs(self.enabledTimers) do
                local name = L['timer:' .. timerData.key]
                local timer = TimersModule.timers[timerData.key]

                local labelText

                if timer == nil then
                    labelText = '|cFF888888[|r???|cFF888888]|r ' .. STATUS_COLOR[0] .. name .. '|r'
                elseif timer.startsAt <= now and timer.endsAt >= now then
                    labelText = '|cFF888888[|r' .. STATUS_COLOR[2] .. self:GetDuration(timer.endsAt - now) ..
                        '|cFF888888]|r ' .. STATUS_COLOR[2] .. name .. '|r'
                    -- timeText = self:GetDuration(timer.endsAt - now)
                else
                    local color = (timer.startsAt - now) <= 300 and STATUS_COLOR[1] or ''
                    labelText = '|cFF888888[|r' .. color .. self:GetDuration(timer.startsAt - now) ..
                        '|r|cFF888888]|r ' .. name .. '|r'
                end

                self:AddLine(timerFrame, labelText)
            end
        end

        table.insert(newChildren, timerFrame)
        seenFrames.timers = true
    end

    -- Get categories and add them
    local categories = self:GetSections()
    for _, category in ipairs(categories) do
        local frameKey = 'category:' .. category.key
        local catFrame = self:GetSectionFrame(frameKey)

        if changed == nil or changed.quests ~= nil then
            catFrame:ReleaseChildren()

            local prefix = self:GetPercentColor(category.completed, category.total)
            local headerText = category.header .. ' - ' .. prefix .. category.completed ..
                '|r|cFF888888/|r' .. prefix .. category.total .. '|r'
            self:AddLine(catFrame, headerText, Addon.db.profile.general.text.fontSize + 1)

            for _, entry in ipairs(category.entries) do
                self:AddLine(catFrame, entry)
            end
        end

        table.insert(newChildren, catFrame)
        seenFrames[frameKey] = true
    end

    -- Release any unused frames
    for key, sectionFrame in pairs(self.sectionFrames) do
        if seenFrames[key] ~= true then
            AceGUI:Release(sectionFrame)
            self.sectionFrames[key] = nil
        end
    end

    self.scrollFrame.children = newChildren
    self.scrollFrame:DoLayout()

    -- local ended = debugprofilestop()
    -- print('redraw took ' .. (ended - started) .. 'ms')
    
    self.haveDrawn = true
end

function Module:GetSectionFrame(key)
    local sectionFrame = self.sectionFrames[key]
    if sectionFrame == nil then
        sectionFrame = AceGUI:Create('SimpleGroup')
        sectionFrame:SetParent(self.scrollFrame)
        sectionFrame:SetLayout('FancyList')
        sectionFrame:SetFullWidth(true)

        sectionFrame.__key = key
        sectionFrame.content.spacing = 4
        
        self.sectionFrames[key] = sectionFrame
    end

    return sectionFrame
end

function Module:GetSections()
    local sections = {}

    local weeklyReset = time() + CDAT_GetSecondsUntilWeeklyReset()
    local week = Addon.db.global.questWeeks[weeklyReset] or {}

    for _, section in ipairs(self.sections) do
        section.completed = 0
        section.total = 0
        section.entries = {}

        for _, chore in ipairs(section.chores) do
            local quest = QuestsModule.quests[chore.data.requiredQuest]
            if chore.data.requiredQuest == nil or (quest ~= nil and quest.status == 2) then
                if chore.typeKey == 'drops' then
                    self:GetSectionDrops(section, chore)
                else
                    self:GetSectionQuests(week, section, chore)
                end
            end
        end

        if section.total > 0 then
            table.insert(sections, section)
        end
    end

    return sections
end

function Module:GetSectionDrops(section, chore)
    local grouped = {}
    for _, choreEntry in ipairs(chore.data.entries) do
        local choreState
        if chore.data.groupSameItem == true then
            if grouped[choreEntry.item] == nil then
                grouped[choreEntry.item] = true
                choreState = {
                    status = 0,
                    completed = 0,
                    total = 0,
                }

                for _, otherEntry in ipairs(chore.data.entries) do
                    if otherEntry.item == choreEntry.item then
                        section.total = section.total + 1
                        choreState.total = choreState.total + 1

                        local otherState = QuestsModule.quests[otherEntry.quest]
                        if otherState.status == 2 then
                            section.completed = section.completed + 1
                            choreState.completed = choreState.completed + 1
                        end
                    end
                end

                if choreState.completed > 0 and choreState.completed < choreState.total then
                    choreState.status = 1
                elseif choreState.completed == choreState.total then
                    choreState.status = 2
                end
            end
        else
            section.total = section.total + 1

            choreState = QuestsModule.quests[choreEntry.quest]
            if choreState.status == 2 then
                section.completed = section.completed + 1
            end
        end

        if choreState ~= nil and (Addon.db.profile.general.display.showCompleted or choreState.status < 2) then
            local entryTranslated = chore.translated
            if choreEntry.desc ~= nil then
                entryTranslated = entryTranslated .. ' (' .. choreEntry.desc .. ')'
            end

            table.insert(
                section.entries,
                self:GetEntryText(entryTranslated, choreEntry, choreState)
            )
        end
    end
end

function Module:GetSectionQuests(week, section, chore)
    section.total = section.total + 1

    local bestEntry
    local bestState = nil
    local bestWeek = nil
    for _, choreEntry in ipairs(chore.data.entries) do
        local entryState = QuestsModule.quests[choreEntry.quest]
        if bestState == nil or bestState.status < entryState.status then
            bestEntry = choreEntry
            bestState = entryState
        end

        local weekState = week[choreEntry.quest]
        if weekState ~= nil and (bestWeek == nil or (bestWeek.status == 2 and weekState.status == 1)) then
            bestWeek = weekState
        end
    end

    if bestState ~= nil and bestState.status == 2 then
        section.completed = section.completed + 1
    end

    if bestState ~= nil and (
            Addon.db.profile.general.display.showCompleted
            or bestState.status < 2
        ) then
        table.insert(
            section.entries,
            self:GetEntryText(chore.translated, bestEntry, bestState, bestWeek, chore.data.inProgressQuestName)
        )

        if bestEntry.shoppingList ~= nil then
            for _, bringMe in ipairs(bestEntry.shoppingList) do
                local bringName = ''
                if bringMe[3] == 'currency' then
                    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(bringMe[2])
                    bringName = currencyInfo.name
                else
                    local itemInfo = self:GetCachedItem(bringMe[2])
                    if itemInfo.valid then
                        bringName = ITEM_QUALITY_COLORS[itemInfo.quality].hex ..
                            itemInfo.name
                    else
                        bringName = ITEM_QUALITY_COLORS[1].hex .. 'Item #' .. bringMe[2]
                    end
                end

                local shoppingText = '    * Bring ' .. bringMe[1] .. 'x ' .. bringName .. '|r'
                table.insert(section.entries, shoppingText)
            end
        elseif bestState.status == 1 and bestState.objectives ~= nil and #bestState.objectives > 1 then
            for _, objective in ipairs(bestState.objectives) do
                local objText = '    * '

                if objective.type == 'item' or
                    objective.type == 'monster' or
                    objective.type == 'object'
                then
                    objText = objText ..
                        self:GetPercentColor(objective.have, objective.need) ..
                        objective.text
                else
                    objText = objText .. objective.type .. '|' .. objective.text ..
                        '|' .. objective.have .. '|' .. objective.need
                end

                table.insert(section.entries, objText)
            end
        end
    end
end

function Module:GetDuration(t)
    local parts = {}

    local hours = math.floor(t / 3600)
    t = t % 3600
    local mins = math.floor(t / 60)

    if hours > 0 then table.insert(parts, hours .. 'h') end
    table.insert(parts, mins .. 'm')

    return table.concat(parts, ' ')
end

function Module:GetEntryText(translated, entry, state, weekState, inProgressQuestName)
    local thingString = ''
    if state.status == 1 and state.objectives ~= nil and #state.objectives == 1 then
        local objective = state.objectives[1]
        thingString = self:GetPercentColor(objective.have, objective.need, true) .. objective.text
    elseif entry.item ~= nil then
        local itemInfo = self:GetCachedItem(entry.item)

        if (state.total or 0) > 1 then
            local color = self:GetPercentColor(state.completed, state.total)
            thingString = color .. state.completed .. '|cFF888888/|r' .. state.total .. '|r '
        end

        if itemInfo.valid then
            table.remove(self.itemRequested, entry.item)

            thingString = thingString .. '|T' .. itemInfo.texture .. ':0|t ' ..
                ITEM_QUALITY_COLORS[itemInfo.quality].hex .. itemInfo.name
        else
            thingString = thingString .. '|cFFFFFFFFItem #' .. entry.item
        end
    elseif state.status == 0 and weekState ~= nil then
        if weekState.objectives ~= nil and #weekState.objectives == 1 then
            local objective = weekState.objectives[1]
            thingString = '|cFFFFFFFF' .. objective.text
        end
    elseif state.status == 1 and inProgressQuestName == false then
        thingString = QuestUtils_GetQuestName(entry.quest)
    else
        thingString = '|cFFFFFFFF' .. QuestUtils_GetQuestName(entry.quest)
    end
    
    if thingString == '' then thingString = '|cFFFFFFFF???' end

    local final = '- '
    if Addon.db.profile.general.display.statusIcons == true then
        final = final .. STATUS_ICON[state.status] .. ' '
    end

    final = final .. STATUS_COLOR[state.status]

    if not (inProgressQuestName == false and state.status == 1) then
        final = final .. translated .. '|r: '
    end

    final = final .. thingString .. '|r'
    return final
end

function Module:GetPercentColor(a, b, ignoreZero)
    if a == 0 and ignoreZero ~= true then
        return STATUS_COLOR[0]
    elseif a < b then
        return STATUS_COLOR[1]
    else
        return STATUS_COLOR[2]
    end
end

function Module:AddLine(frame, text, size)
    local label = AceGUI:Create('Label')
    label:SetFont(self.font, size or Addon.db.profile.general.text.fontSize, '')
    label:SetFullWidth(true)
    label:SetText(text)
    label.label:SetWordWrap(false)
    frame:AddChild(label)
end

function Module:GetCachedItem(itemId)
    local itemInfo = self.itemCache[itemId] or {}

    if itemInfo.name == nil then
        itemInfo.name = C_Item.GetItemNameByID(itemId)
    end
    if itemInfo.quality == nil then
        itemInfo.quality = C_Item.GetItemQualityByID(itemId)
    end
    if itemInfo.texture == nil then
        itemInfo.texture = C_Item.GetItemIconByID(itemId)
    end

    itemInfo.valid = itemInfo.name ~= nil and itemInfo.quality ~= nil and itemInfo.texture ~= nil
    if not itemInfo.valid then
        C_Item.RequestLoadItemDataByID(itemId)
        self.itemRequested[itemId] = true
    end

    self.itemCache[itemId] = itemInfo

    return itemInfo
end

-- Global function for key binding
function ChoreTracker_ToggleShown()
    Module:ToggleShown()
end
