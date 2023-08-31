local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Display')


local CDAT_GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset
local LSM = LibStub('LibSharedMedia-3.0')

local STATUS_COLOR = {
    [0] = '|cFFFF2222',
    [1] = '|cFFFFFF00',
    [2] = '|cFF00FF00',
}
local PADDING_OUTER = 8

function Module:OnEnable()
    self.fontStrings = {}
    self.fsPool = {}
    self.itemCache = {}
    self.itemRequested = {}

    Addon.db.RegisterCallback(self, 'OnProfileChanged', 'ConfigChanged')
    Addon.db.RegisterCallback(self, 'OnProfileCopied', 'ConfigChanged')
    Addon.db.RegisterCallback(self, 'OnProfileReset', 'ConfigChanged')

    self:CreateFrame()

    self:RegisterMessage('ChoreTracker_Config_Changed', 'ConfigChanged')
    self:RegisterBucketMessage({ 'ChoreTracker_Quests_Updated', }, 0.5, 'Redraw')

    self:RegisterBucketEvent(
        { 'ZONE_CHANGED', 'ZONE_CHANGED_INDOORS', 'ZONE_CHANGED_NEW_AREA' },
        1,
        'UpdateZone'
    )

    self:RegisterBucketEvent({ 'ITEM_DATA_LOAD_RESULT' }, 1, 'ItemsLoaded')
end

function Module:OnEnteringWorld()
    self:UpdateZone()
end

function Module:UpdateZone()
    if IsInInstance() then
        self.frame:Hide()
    else
        self.frame:Show()
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
            header = header ..'|r'

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
                        if Addon.db.profile.chores[sectionKey][catData.key][typeKey][choreData.key] == true then
                            section.total = section.total + 1
                            table.insert(section.chores, {
                                data = choreData,
                                translated = L['chore:' .. catData.key .. ':' .. typeKey .. ':' .. choreData.key],
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

function Module:Redraw()
    if self.sections == nil then
        self:ConfigChanged()
        return
    end

    print('redraw')

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
        self:AddLine(headerText)

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

    self.frame:SetHeight(totalHeight + ((#self.fontStrings - 1) * 5) + (PADDING_OUTER * 2))
    self.frame:SetWidth(maxWidth + (PADDING_OUTER * 2))
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
                    for _, choreEntry in ipairs(chore.data.entries) do
                        section.total = section.total + 1

                        local choreState = questsModule.quests[choreEntry.quest]
                        if choreState.status == 2 then
                            section.completed = section.completed + 1
                        end

                        if Addon.db.profile.general.showCompleted or choreState.status < 2 then
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
                            self:GetEntryText(chore.translated, bestEntry, bestState, bestWeek)
                        )

                        if bestState.status == 1 and bestState.objectives ~= nil and #bestState.objectives > 1 then
                            for _, objective in ipairs(bestState.objectives) do
                                local objText = '    * '

                                if objective.type == 'item' then
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

function Module:GetEntryText(translated, entry, state, weekState)
    local thingString = ''
    if state.status == 1 and state.objectives ~= nil and #state.objectives == 1 then
        local objective = state.objectives[1]
        thingString = self:GetPercentColor(objective.have, objective.need, true) .. objective.text
    elseif entry.item ~= nil then
        local itemInfo = self:GetCachedItem(entry.item)

        if itemInfo.name ~= nil and itemInfo.quality ~= nil and itemInfo.texture ~= nil then
            table.remove(self.itemRequested, entry.item)

            thingString = '|T' .. itemInfo.texture .. ':0|t ' ..
                ITEM_QUALITY_COLORS[itemInfo.quality].hex .. itemInfo.name
        else
            C_Item.RequestLoadItemDataByID(entry.item)
            self.itemRequested[entry.item] = true

            thingString = '|cFFFFFFFFItem #' .. entry.item
        end
    elseif state.status == 0 and weekState ~= nil then
        if weekState.objectives ~= nil and #weekState.objectives == 1 then
            local objective = weekState.objectives[1]
            thingString = '|cFFFFFFFF' .. objective.text
        end
    else
        thingString = '|cFFFFFFFF' .. QuestUtils_GetQuestName(entry.quest)
    end
    
    if thingString == '' then thingString = '|cFFFFFFFF???' end

    return '- ' .. STATUS_COLOR[state.status] .. translated .. '|r: ' .. thingString .. '|r'
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

function Module:AddLine(text)
    local fontString = table.remove(self.fsPool) or self.frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    fontString:SetText(text)

    local font = LSM:Fetch('font', Addon.db.profile.general.text.font)
    fontString:SetFont(font, Addon.db.profile.general.text.fontSize)

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

    self.itemCache[itemId] = itemInfo

    return itemInfo
end
