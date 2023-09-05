local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Display', 'AceHook-3.0')

local LSM = LibStub('LibSharedMedia-3.0')

BINDING_HEADER_CHORETRACKER = addonName
BINDING_NAME_CHORETRACKER_TOGGLE = Addon.L['key_binding:toggle']

local CC_GetDayEvent = C_Calendar.GetDayEvent
local CC_GetNumDayEvents = C_Calendar.GetNumDayEvents
local CDAT_CompareCalendarTime = C_DateAndTime.CompareCalendarTime
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
local PADDING_OUTER = 8

function Module:OnEnable()
    if not IsAddOnLoaded('Blizzard_Calendar') then
        UIParentLoadAddOn('Blizzard_Calendar')
    end

    self.dontShow = false
    self.fontStrings = {}
    self.fsPool = {}
    self.itemCache = {}
    self.itemRequested = {}

    Addon.db.RegisterCallback(self, 'OnProfileChanged', 'ConfigChanged')
    Addon.db.RegisterCallback(self, 'OnProfileCopied', 'ConfigChanged')
    Addon.db.RegisterCallback(self, 'OnProfileReset', 'ConfigChanged')

    self:HookScript(CalendarFrame, 'OnHide', 'ResetCalendar')

    self:RegisterMessage('ChoreTracker_Config_Changed', 'ConfigChanged')
    self:RegisterBucketMessage({ 'ChoreTracker_Quests_Updated', }, 0.5, 'Redraw')

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

    self:CreateFrame()
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

function Module:CreateFrame()
    local frame = CreateFrame('Frame', 'ChoreTrackerFrame', UIParent, 'BackdropTemplate')
    frame:SetBackdrop({
        bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background',
        edgeFile = [[Interface\Buttons\WHITE8X8]],
        edgeSize = 1,
        tile = true,
        tileSize = 16,
    })
    frame:SetBackdropColor(0, 0, 0, 0.7)
    frame:SetBackdropBorderColor(63/255, 63/255, 63/255, 0.7)
    -- frame:SetFrameStrata('MEDIUM')
    frame:SetHeight(1)
    frame:SetWidth(1)
    frame:SetPoint('TOPLEFT', UIParent, 'BOTTOMLEFT', Addon.db.profile.position.x, Addon.db.profile.position.y)

    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag('LeftButton')
    frame:SetScript('OnDragStart', self.OnDragStart)
    frame:SetScript('OnDragStop', self.OnDragStop)

    self.frame = frame
end

function Module:OnDragStart()
    self:StartMoving()
end

function Module:OnDragStop()
    self:StopMovingOrSizing()

    Addon.db.profile.position.x = self:GetLeft()
    Addon.db.profile.position.y = self:GetTop()
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
    local questsModule = Addon:GetModule('Quests')

    if self.sortedSections == nil then
        self.sortedSections = {}
        for sectionKey, sectionData in pairs(Addon.data) do
            table.insert(self.sortedSections, { sectionKey, sectionData })
        end
        table.sort(self.sortedSections, function(a, b) return a[2].order < b[2].order end)
    end

    self.activeEvents = self.activeEvents or {}

    -- Check which events are active if the calendar is set to the correct year/month
    local now = CDAT_GetCurrentCalendarTime()
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

    self.sections = {}
    for _, sectionTemp in ipairs(self.sortedSections) do
        local sectionKey, sectionData = unpack(sectionTemp)
        if sectionData.skillLineId == nil or questsModule.skillLines[sectionData.skillLineId] == true then
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
                header = header,
                completed = 0,
                total = 0,
                chores = {},
                entries = {},
            }

            for _, catData in ipairs(sectionData.categories) do
                for _, typeKey in ipairs({ 'quests', 'drops' }) do
                    for _, choreData in ipairs(catData[typeKey] or {}) do
                        if Addon.db.profile.chores[sectionKey][catData.key][typeKey][choreData.key] == true and
                            (
                                choreData.requiredEventIds == nil or
                                self:AnyActive(self.activeEvents, choreData.requiredEventIds)
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

            if section.total > 0 then
                table.insert(self.sections, section)
            end
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

function Module:Redraw()
    if self.sections == nil then
        self:ConfigChanged()
        return
    end

    -- print('redraw')

    -- Hide text and return to pool
    for _, fontString in ipairs(self.fontStrings) do
        fontString:Hide()
        table.insert(self.fsPool, fontString)
    end
    self.fontStrings = {}

    -- Get categories and add them
    local categories = self:GetSections()
    for _, category in ipairs(categories) do
        local prefix = self:GetPercentColor(category.completed, category.total)
        local headerText = category.header .. ' - ' .. prefix .. category.completed ..
            '|r|cFF888888/|r' .. prefix .. category.total .. '|r'
        self:AddLine(headerText, Addon.db.profile.general.text.fontSize + 1)

        for _, entry in ipairs(category.entries) do
            self:AddLine(entry)
        end
    end

    -- Now we can resize I guess?
    local maxWidth = 0
    local totalHeight = 0
    for _, fontString in ipairs(self.fontStrings) do
        totalHeight = totalHeight + fontString:GetHeight()
        local width = fontString:GetWidth()
        if width > maxWidth then
            maxWidth = width
        end
    end

    local xPos = self.frame:GetLeft()
    local yPos = self.frame:GetTop()

    self.frame:SetHeight(totalHeight + ((#self.fontStrings - 1) * 5) + (PADDING_OUTER * 2))
    self.frame:SetWidth(maxWidth + (PADDING_OUTER * 2))

    self.frame:ClearAllPoints()
    self.frame:SetPoint('TOPLEFT', UIParent, 'BOTTOMLEFT', xPos, yPos)
end

function Module:GetSections()
    local sections = {}
    local questsModule = Addon:GetModule('Quests')

    local weeklyReset = time() + CDAT_GetSecondsUntilWeeklyReset()
    local week = Addon.db.global.questWeeks[weeklyReset] or {}

    for _, section in ipairs(self.sections) do
        section.completed = 0
        section.total = 0
        section.entries = {}

        for _, chore in ipairs(section.chores) do
            if chore.data.requiredQuest == nil or questsModule.quests[chore.data.requiredQuest].status == 2 then
                if chore.typeKey == 'drops' then
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

                                        local otherState = questsModule.quests[otherEntry.quest]
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

                            choreState = questsModule.quests[choreEntry.quest]
                            if choreState.status == 2 then
                                section.completed = section.completed + 1
                            end
                        end
    
                        if choreState ~= nil and (Addon.db.profile.general.showCompleted or choreState.status < 2) then
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
                else
                    section.total = section.total + 1

                    local bestEntry
                    local bestState = nil
                    local bestWeek = nil
                    for _, choreEntry in ipairs(chore.data.entries) do
                        local entryState = questsModule.quests[choreEntry.quest]
                        if bestState == nil or bestState.status < entryState.status then
                            bestEntry = choreEntry
                            bestState = entryState
                        end

                        local weekState = week[choreEntry.quest]
                        if weekState ~= nil and (bestWeek == nil or (bestWeek.status == 2 and weekState.status == 1)) then
                            bestWeek = weekState
                        end
                    end

                    if bestState.status == 2 then
                        section.completed = section.completed + 1
                    end

                    if Addon.db.profile.general.showCompleted or bestState.status < 2 then
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
            end
        end

        if section.total > 0 then
            table.insert(sections, section)
        end
    end

    return sections
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
    if Addon.db.profile.general.statusIcons == true then
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

function Module:AddLine(text, size)
    local fontString = table.remove(self.fsPool) or self.frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    fontString:SetText(text)

    local font = LSM:Fetch('font', Addon.db.profile.general.text.font)
    fontString:SetFont(font, size or Addon.db.profile.general.text.fontSize)

    if #self.fontStrings == 0 then
        fontString:SetPoint('TOPLEFT', self.frame, 'TOPLEFT', PADDING_OUTER, -PADDING_OUTER)
    else
        fontString:SetPoint('TOPLEFT', self.fontStrings[#self.fontStrings], 'BOTTOMLEFT', 0, -5)
    end

    fontString:Show()

    table.insert(self.fontStrings, fontString)
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
