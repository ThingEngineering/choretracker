local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule(
    'Display',
    {
        delvesEnabled = false,
        dontShow = false,
        enabledTimers = {},
        itemCache = {},
        itemRequested = {},
        sectionFrames = {},
    },
    'AceHook-3.0'
)

local ScannerModule
local TimersModule

local AceGUI = LibStub('AceGUI-3.0')
local LSM = LibStub('LibSharedMedia-3.0')

BINDING_HEADER_CHORETRACKER = addonName
BINDING_NAME_CHORETRACKER_TOGGLE = Addon.L['key_binding:toggle']

local CC_GetDayEvent = C_Calendar.GetDayEvent
local CC_GetNumDayEvents = C_Calendar.GetNumDayEvents
local CCI_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
local CDAT_CompareCalendarTime = C_DateAndTime.CompareCalendarTime
local CDAT_GetCalendarTimeFromEpoch = C_DateAndTime.GetCalendarTimeFromEpoch
local CDAT_GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
local CDAT_GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset
local CMI_GetModifiedInstanceInfoFromMapID = C_ModifiedInstance.GetModifiedInstanceInfoFromMapID

local OBJECTIVE_DEFEAT_X = Addon.L['objective:defeat_x']
local OBJECTIVE_BRING_X = Addon.L['objective:bring_x']

local SECTION_TO_CATEGORIES = {
    anniversary = { 'choresAnniversary' },
    dragonflight = { 'choresDragonflight' },
    events = { 'choresEvents' },
    hallowfallFishingDerby = { 'choresHallowfallFishingDerby' },
    pvp = { 'choresPvp' },
    warWithin = { 'choresWarWithin' },
    professions = {
        'professionAlchemy',
        'professionBlacksmithing',
        'professionEnchanting',
        'professionEngineering',
        'professionHerbalism',
        'professionInscription',
        'professionJewelcrafting',
        'professionLeatherworking',
        'professionMining',
        'professionSkinning',
        'professionTailoring',
        'professionArchaeology',
        'professionCooking',
        'professionFishing',
    },
}

local REGION_OFFSET = {
    [1] = -(7 * 60 * 60), -- US events use PST (-0700 UTC)
    --[2] = ??, -- KR
    [3] = (1 * 60 * 60),  -- EU events use CEDT? (+0100 UTC)
    --[4] = ??, -- TW
}
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
local KEY_ICON = '|T4622270:0|t'

function Module:OnEnable()
    ScannerModule = Addon:GetModule('Scanner')
    TimersModule = Addon:GetModule('Timers')

    if not C_AddOns.IsAddOnLoaded('Blizzard_Calendar') then
        UIParentLoadAddOn('Blizzard_Calendar')
    end

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

    self.frame.frame:SetFrameStrata(Addon.db.profile.general.appearance.strata)
    self.frame:SetBackgroundColor(Addon.db.profile.general.appearance.backgroundColor)
    self.frame:SetBorderColor(Addon.db.profile.general.appearance.borderColor)

    if self.sortedSections == nil then
        self.sortedSections = {}
        for sectionKey, sectionData in pairs(Addon.data.chores) do
            table.insert(self.sortedSections, { sectionKey, sectionData })
        end
        table.sort(self.sortedSections, function(a, b) return a[2].order < b[2].order end)
    end

    self.activeEvents = self.activeEvents or {}

    -- If we have data about what timezone calendar events are actually in, mangle the
    -- timezones a little to use the correct offset. FFS, Blizzard.
    local unixTime = time()
    local region = GetCurrentRegion()
    if REGION_OFFSET[region] ~= nil then
        local offset = self:GetTimeZoneOffset(unixTime)
        unixTime = unixTime - offset + REGION_OFFSET[region]
    end

    local now = CDAT_GetCalendarTimeFromEpoch(unixTime * 1000000)

    -- Check which events are active if the calendar is set to the correct year/month.
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

    -- Delves
    self.delvesEnabled = playerLevel == 80

    -- Events
    self.sections = {}
    for _, sectionTemp in ipairs(self.sortedSections) do
        local sectionKey, sectionData = unpack(sectionTemp)
        if
            (
                sectionData.skillLineId == nil or
                Addon.db.char.skillLines[sectionData.skillLineId] ~= nil
            ) and (
                sectionData.filter == nil or
                sectionData.filter() == true
            ) and self:PlayerLevelOk(sectionData, playerLevel)
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
                if catData.skillLineId == nil or
                    Addon.db.char.skillLines[catData.skillLineId] ~= nil
                then
                    -- Show an info message about missing skill level
                    if Addon.db.char.skillLines[catData.skillLineId] == -1 then
                        table.insert(section.chores, {
                            data = {},
                            translated = L['missing_skill_level'],
                            typeKey = 'warning',
                        })
                    end

                    for _, typeKey in ipairs({ 'dungeons', 'quests', 'drops' }) do
                        for _, choreData in ipairs(catData[typeKey] or {}) do
                            local choreEnabled = Addon.db.profile.chores[sectionKey][catData.key][typeKey][choreData.key]
                            if choreEnabled == true
                                and (
                                    choreData.requiredEventIds == nil or
                                    self:AnyActive(self.activeEvents, choreData.requiredEventIds)
                                )
                                and (
                                    choreData.skill == nil or
                                    Addon.db.char.skillLines[catData.skillLineId] >= choreData.skill
                                )
                                and (
                                    choreData.filter == nil or
                                    choreData.filter() == true
                                )
                                and self:PlayerLevelOk(choreData, playerLevel)
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
    for _, category in pairs(Addon.data.timers) do
        for _, timerData in ipairs(category.timers) do
            if Addon.db.profile.timers[category.key][timerData.key] == true and
                self:PlayerLevelOk(timerData, playerLevel)
            then
                table.insert(self.enabledTimers, timerData)
            end
        end
    end

    self:Redraw()
end

function Module:GetTimeZoneOffset(now)
    local localDate = date('*t', now)
    localDate.isdst = false
    local utcDate = date('!*t', now)
    return difftime(time(localDate), time(utcDate))
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

    local categories = self:GetSections()
    local categoryMap = {}
    for _, category in ipairs(categories) do
        categoryMap[category.key] = category
    end

    local newChildren = {}
    local seenFrames = {}

    for _, section in ipairs(Addon.db.profile.general.order.sections) do
        if section == 'timers' then
            self:AddTimers(changed, newChildren, seenFrames)
        elseif section == 'delves' then
            self:AddDelves(changed, newChildren, seenFrames)
            -- elseif section == 'events' then
        else
            local sectionCategories = SECTION_TO_CATEGORIES[section] or {}
            for _, sectionCategory in ipairs(sectionCategories) do
                local categoryData = categoryMap[sectionCategory]
                if categoryData ~= nil then
                    self:AddChores(changed, newChildren, seenFrames, categoryData)
                end
            end
        end
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

function Module:AddChores(changed, newChildren, seenFrames, category)
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

function Module:AddDelves(changed, newChildren, seenFrames)
    if self.delvesEnabled and Addon.db.profile.delves.bountiful.showDelves then
        local delvesFrame = self:GetSectionFrame('delves')

        if changed == nil or changed.pois ~= nil then
            delvesFrame:ReleaseChildren()

            local onlyWithKeys = Addon.db.profile.delves.bountiful.onlyWithKeys
            local showCompletedSections = Addon.db.profile.general.display.showCompletedSections
            local showCompletedChores = Addon.db.profile.general.display.showCompleted
            local showKeys = Addon.db.profile.delves.bountiful.showKeys
            local showStatusIcons = Addon.db.profile.general.display.statusIcons

            local completed = 0
            local total = 0
            local labelTexts = {}
            for _, sectionData in pairs(Addon.data.delves) do
                for _, mapData in ipairs(sectionData.zones) do
                    local mapInfo = C_Map.GetMapInfo(mapData.uiMapId)
                    for _, poi in ipairs(mapData.pois) do
                        local labelText
                        local status = -1

                        local poiData = ScannerModule.pois[poi.active]
                        if poiData ~= nil then
                            -- available
                            labelText = STATUS_COLOR[0] .. mapInfo.name .. '|r: ' .. poiData.name
                            total = total + 1
                            status = 0
                        else
                            poiData = ScannerModule.pois[poi.inactive]
                            local quest = ScannerModule.quests[poi.quest]
                            if quest ~= nil and quest.status == 2 then
                                total = total + 1
                                completed = completed + 1
                                status = 2

                                if showCompletedChores then
                                    labelText = STATUS_COLOR[2] .. mapInfo.name .. '|r: ' .. poiData.name
                                end
                            end
                        end
                    
                        if labelText ~= nil then
                            local finalText = '- '

                            if showStatusIcons == true then
                                finalText = finalText .. STATUS_ICON[status] .. ' '
                            end
                            
                            finalText = finalText .. labelText

                            tinsert(labelTexts, finalText)
                        end
                    end
                end
            end

            local keyCount = CCI_GetCurrencyInfo(3028).quantity

            if (completed < total or showCompletedSections) and
                (not onlyWithKeys or keyCount > 0)
            then
                local prefix = self:GetPercentColor(completed, total)

                local headerText = L['category:bountifulDelves']
                if showKeys then
                    local keyColor = self:GetPercentColor(keyCount, total - completed)
                    headerText = headerText .. ' |cFF888888[|r' .. keyColor .. keyCount .. '|r ' .. KEY_ICON .. '|cFF888888]|r'
                end
                headerText = headerText .. ' - ' .. prefix .. completed .. '|r|cFF888888/|r' .. prefix ..
                    total .. '|r'

                self:AddLine(delvesFrame, headerText, Addon.db.profile.general.text.fontSize + 1)

                for _, labelText in ipairs(labelTexts) do
                    self:AddLine(delvesFrame, labelText)
                end
            end
        end

        if #delvesFrame.children > 0 then
            table.insert(newChildren, delvesFrame)
            seenFrames.delves = true
        end
    end
end

function Module:AddTimers(changed, newChildren, seenFrames)

    -- Timers
    if #self.enabledTimers > 0 then
        local awakenedTimers = Addon.db.profile.general.display.awakenedTimers
        local timerFrame = self:GetSectionFrame('timers')

        if changed == nil or changed.timers ~= nil then
            timerFrame:ReleaseChildren()

            local now = time()
            for _, timerData in ipairs(self.enabledTimers) do
                if (awakenedTimers == false or
                    timerData.awakenedMap == nil or
                    CMI_GetModifiedInstanceInfoFromMapID(timerData.awakenedMap) ~= nil
                ) then
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
        end

        table.insert(newChildren, timerFrame)
        seenFrames.timers = true
    end
end

function Module:GetSections()
    local sections = {}

    local showAnniversaryAccount = Addon.db.profile.general.display.showAnniversaryAccount
    local showCompletedSections = Addon.db.profile.general.display.showCompletedSections
    local showCompletedChores = Addon.db.profile.general.display.showCompleted
    local showObjectives = Addon.db.profile.general.display.showObjectives
    local weeklyReset = time() + CDAT_GetSecondsUntilWeeklyReset()
    local week = Addon.db.global.questWeeks[weeklyReset] or {}

    for _, section in ipairs(self.sections) do
        section.completed = 0
        section.total = 0
        section.entries = {}
        section.usedQuests = {}

        for _, chore in ipairs(section.chores) do
            if chore.typeKey == 'warning' then
                table.insert(section.entries, chore.translated)
            else
                local quest = ScannerModule.quests[chore.data.requiredQuest]
                if chore.data.requiredQuest == nil or (quest ~= nil and quest.status == 2) then
                    if chore.typeKey == 'drops' or chore.data.groupSameItem == true then
                        self:GetSectionDrops(section, chore)
                    elseif chore.typeKey == 'dungeons' then
                        self:GetSectionDungeons(section, chore)
                    else
                        self:GetSectionQuests(week, section, chore, showAnniversaryAccount, showCompletedChores, showObjectives)
                    end
                end
            end
        end

        if section.total > 0 and (showCompletedSections == true or section.completed < section.total) then
            table.insert(sections, section)
        end
    end

    return sections
end

function Module:GetSectionDungeons(section, chore)
    section.total = section.total + 1

    local dungeonState = ScannerModule.dungeons[chore.data.dungeonId]
    if dungeonState == true then
        section.completed = section.completed + 1
    end

    if dungeonState ~= nil and (Addon.db.profile.general.display.showCompleted or dungeonState == false) then
        local status = dungeonState == true and 2 or 0
        local text = '- '
        if Addon.db.profile.general.display.statusIcons == true then
            text = text .. STATUS_ICON[status] .. ' '
        end
    
        text = text .. STATUS_COLOR[status] .. chore.translated .. '|r'

        table.insert(
            section.entries,
            text
        )
    end
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

                        local otherState = ScannerModule.quests[otherEntry.quest]
                        if otherState ~= nil and otherState.status == 2 then
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

            choreState = ScannerModule.quests[choreEntry.quest]
            if choreState ~= nil and choreState.status == 2 then
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
                self:GetEntryText(entryTranslated, choreEntry, choreState, nil, {})
            )
        end
    end
end

function Module:GetSectionQuests(week, section, chore, showAnniversaryAccount, showCompleted, showObjectives)
    local pick = chore.data.pick or 1
    section.total = section.total + pick

    local byStatus = {
        [0] = {},
        [1] = {},
        [2] = {},
    }

    for _, choreEntry in ipairs(chore.data.entries or {}) do
        local questIds = { choreEntry.quest }
        if choreEntry.actualQuest then tinsert(questIds, choreEntry.actualQuest) end
        if choreEntry.unlockQuest then tinsert(questIds, choreEntry.unlockQuest) end
        
        for index, questId in ipairs(questIds) do
            local entryState = ScannerModule.quests[questId]
            if entryState ~= nil then
                if entryState.accountCompleted and (
                    chore.data.oncePerAccount or
                    (chore.data.anniversaryAccount and not showAnniversaryAccount)
                ) then
                    entryState = {
                        objectives = entryState.objectives,
                        status = 2,
                    }
                end

                if entryState.status > 0 or index == #questIds then
                    table.insert(byStatus[entryState.status], {
                        choreEntry,
                        entryState,
                        week[questId],
                    })
                    break
                end
            end
        end
    end

    if #byStatus[0] > 0 or #byStatus[1] > 0 or #byStatus[2] > 0 then
        for i = 1, pick do
            local bestEntry, bestState, bestWeek
            if #byStatus[1] > 0 then
                bestEntry, bestState, bestWeek = unpack(tremove(byStatus[1], 1))
            elseif #byStatus[2] > 0 then
                bestEntry, bestState, bestWeek = unpack(tremove(byStatus[2], 1))
                section.completed = section.completed + 1
            else
                for j = 1, #byStatus[0] do
                    bestEntry, bestState, bestWeek = unpack(byStatus[0][j])
                    if bestWeek ~= nil and bestWeek.status > 0 then
                        tremove(byStatus[0], j)
                        break
                    end
                end

                -- If we didn't find anything valid, use the first quest
                if bestWeek == nil then
                    bestEntry, bestState, bestWeek = unpack(tremove(byStatus[0], 1))
                end
            end

            if bestState ~= nil and (showCompleted or bestState.status < 2) then
                table.insert(
                    section.entries,
                    self:GetEntryText(chore.translated, bestEntry, bestState, bestWeek, chore.data)
                )

                if bestState.status < 2 then
                    if chore.data.useShoppingListAsName ~= true and bestEntry.shoppingList ~= nil then
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

                            local shoppingText = '    * ' .. string.format(OBJECTIVE_BRING_X, bringMe[1], bringName) .. '|r'
                            table.insert(section.entries, shoppingText)
                        end
                    elseif bestState.status == 1 then
                        if bestState.objectives ~= nil and
                            (#bestState.objectives > 1 or chore.data.alwaysShowObjectives)
                        then
                            self:AddObjectives(section.entries, bestState.objectives, showObjectives)
                        elseif bestWeek ~= nil and bestWeek.objectives ~= nil and
                            (#bestWeek.objectives > 1 or chore.data.alwaysShowObjectives) then
                            self:AddObjectives(section.entries, bestWeek.objectives, showObjectives)
                        end
                    elseif bestWeek ~= nil and bestWeek.objectives ~= nil and
                        (#bestWeek.objectives > 1 or chore.data.alwaysShowObjectives) then
                        self:AddObjectives(section.entries, bestWeek.objectives, showObjectives)
                    end
                end
            end
        end
    end
end

function Module:AddObjectives(entries, objectives, showObjectives)
    if showObjectives == 'NONE' then return end

    local numObjectives = #objectives
    for index, objective in ipairs(objectives) do
        local objText
        local showThis = showObjectives == 'ALL' or
            objective.have < objective.need or
            (objective.have == objective.need and index == numObjectives)

        if objective.type == 'item' or
            objective.type == 'monster' or
            objective.type == 'object'
        then
            if showThis then
                objText = '    * ' ..
                    self:GetPercentColor(objective.have, objective.need) ..
                    objective.text
            end
        elseif objective.type == 'progressbar' then
            if showThis then
                objText = '    * ' ..
                    self:GetPercentColor(objective.have, objective.need) ..
                    objective.have ..
                    '% ' ..
                    objective.text
            end
        else
            objText = objText .. objective.type .. '|' .. objective.text ..
                '|' .. objective.have .. '|' .. objective.need
        end

        if objText ~= nil then
            table.insert(entries, objText)
        end
    end
end

function Module:GetDuration(t)
    local parts = {}

    local hours = math.floor(t / 3600)
    t = t % 3600
    local mins = math.floor((t / 60) + 0.5)

    if hours > 0 then table.insert(parts, hours .. 'h') end
    table.insert(parts, mins .. 'm')

    return table.concat(parts, ' ')
end

function Module:GetEntryText(translated, entry, state, weekState, options)
    -- options = { inProgressQuestName, useShoppingListAsName }
    local questName = QuestUtils_GetQuestName(entry.actualQuest or entry.quest)
    if questName == nil or questName == '' then
        if entry.encounter then
            local _, name = EJ_GetCreatureInfo(entry.encounter[2], entry.encounter[1])
            questName = string.format(OBJECTIVE_DEFEAT_X, name)
        else
            -- This will just return the key if there's no translation entry, check for that
            local translatedName = L['questName:' .. entry.quest]
            if translatedName:find('^questName:') == nil then
                questName = translatedName
            else
                questName = '???'
            end
        end
    elseif options.removeText then
        questName = questName:gsub(options.removeText, '')
    end

    local thingString = ''
    if state.status <= 1 and options.alwaysQuestName then
        thingString = '|cFFFFFFFF' .. questName
    elseif state.status == 1 and state.objectives ~= nil and #state.objectives == 1 and not options.alwaysShowObjectives then
        local objective = state.objectives[1]
        thingString = self:GetPercentColor(objective.have, objective.need, true) .. self:ObjectiveText(objective)
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
    elseif state.status == 0 and options.chooseQuest then
        thingString = '|cFFFFFFFF' .. L['choose_quest']
    elseif state.status == 0 and weekState ~= nil then
        if weekState.objectives ~= nil and #weekState.objectives == 1 then
            local objective = weekState.objectives[1]
            thingString = '|cFFFFFFFF' .. self:ObjectiveText(objective)
        else
            thingString = '|cFFFFFFFF' .. questName
        end
    elseif state.status == 1 and options.inProgressQuestName == false then
        thingString = questName
    elseif options.useShoppingListAsName == true then
        local bringName = ''
        local itemCount, itemId = unpack(entry.shoppingList[1])
        local itemInfo = self:GetCachedItem(itemId)
        if itemInfo.valid then
            bringName = ITEM_QUALITY_COLORS[itemInfo.quality].hex .. itemInfo.name
        else
            bringName = ITEM_QUALITY_COLORS[1].hex .. 'Item #' .. itemId
        end

        thingString = '|cFFFFFFFF' .. itemCount .. 'x ' .. bringName
    else
        thingString = '|cFFFFFFFF' .. questName
    end
    
    if thingString == '' then thingString = '|cFFFFFFFF???' end

    local final = '- '
    if Addon.db.profile.general.display.statusIcons == true then
        final = final .. STATUS_ICON[state.status] .. ' '
    end

    if options.dailyQuest then
        final = final .. '|cFF00CFFF[D] '
    end

    final = final .. STATUS_COLOR[state.status]

    if not (options.inProgressQuestName == false and state.status == 1) and
        not (options.onlyItemName == true and entry.item ~= nil)
    then
        final = final .. translated
        if not options.noText then
            final = final .. '|r: '
        end
    end

    if not options.noText then
        final = final .. thingString .. '|r'
    end

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

function Module:ObjectiveText(objective)
    if objective.type == 'progressbar' then
        return objective.have .. '% ' .. objective.text
    else
        return objective.text
    end
end

function Module:AddLine(frame, text, size)
    local label = AceGUI:Create('Label')
    label:SetFont(self.font, size or Addon.db.profile.general.text.fontSize, Addon.db.profile.general.text.fontStyle)
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

function Module:PlayerLevelOk(data, playerLevel)
    return data.minimumLevel == nil or playerLevel >= data.minimumLevel
end

-- Global function for key binding
function ChoreTracker_ToggleShown()
    Module:ToggleShown()
end
