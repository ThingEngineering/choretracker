local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Display')


local CHORE_PREFIX = {
    [0] = '- |cFFFF0000',
    [1] = '- |cFFFFFF00',
    [2] = '- |cFF00FF00',
}
local PADDING_OUTER = 8

function Module:OnEnable()
    self.fontStrings = {}
    self.fsPool = {}
    self.itemCache = {}
    self.itemRequested = {}

    self:CreateFrame()

    self:RegisterMessage('ChoreTracker_Config_Changed', 'Redraw')
    self:RegisterMessage('ChoreTracker_Quests_Updated', 'Redraw')
    
    self:RegisterBucketEvent({ 'ITEM_DATA_LOAD_RESULT' }, 1, 'ItemsLoaded')
end

function Module:OnEnteringWorld()
    self.frame:Show()
end

function Module:CreateFrame()
    local frame = CreateFrame('Frame', 'ChoreTrackerFrame', UIParent, 'BackdropTemplate')
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = [[Interface\Buttons\WHITE8X8]],
        edgeSize = 1,
        tile = true,
        tileSize = 16,
    })
    frame:SetBackdropColor(0, 0, 0, 0.6)
    frame:SetBackdropBorderColor(63/255, 63/255, 63/255, 0.6)
    -- frame:SetFrameStrata('MEDIUM')
    frame:SetHeight(300)
    frame:SetWidth(280)
    frame:SetPoint('TOPLEFT', 100, -100)

    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag('LeftButton')
    frame:SetScript('OnDragStart', self.OnDragStart)
    frame:SetScript('OnDragStop', self.OnDragStop)

    self.frame = frame
end

function Module:OnDragStart()
    print('WE STARTING')
    self:StartMoving()
end

function Module:OnDragStop()
    print('WE STOPPING')
    self:StopMovingOrSizing()
    local left = self:GetLeft()
    local top = self:GetTop()
    print('top: '..top..' | left: '..left)
end

function Module:ItemsLoaded(data)
    local weCare = false
    for itemId, _ in pairs(data) do
        if self.itemRequested[itemId] == true then
            print('we care! '..itemId)
            weCare = true
            break
        end
    end
    
    if weCare then
        self:Redraw()
    end
end

function Module:Redraw()
    print('redraw')

    local questsModule = Addon:GetModule('Quests')

    for _, fontString in ipairs(self.fontStrings) do
        fontString:Hide()
        table.insert(self.fsPool, fontString)
    end

    self.fontStrings = {}

    for profKey, profData in pairs(Addon.data.professions) do
        if questsModule.skillLines[profData.skillLineId] == true then
            -- Add profession icon and name
            local profInfo = C_TradeSkillUI.GetProfessionInfoBySkillLineID(profData.skillLineId)
            self:AddLine('|T' .. profData.texture .. ':0|t |cFFFFFFFF' .. profInfo.professionName .. '|r')

            -- Quests
            for _, catKey in ipairs({ 'quests', 'drops' }) do
                for _, choreData in ipairs(profData.expansions.dragonflight[catKey]) do
                    if Addon.db.profile.professions[profKey].dragonflight[catKey][choreData.key] == true then
                        local translated = L['section_' .. catKey .. '_' .. choreData.key]

                        if catKey == 'drops' then
                            for _, choreEntry in ipairs(choreData.entries) do
                                local choreState = questsModule.quests[choreEntry.quest]
                                if Addon.db.profile.general.showCompleted or choreState.status < 2 then
                                    local entryTranslated = translated
                                    if choreEntry.desc ~= nil then
                                        entryTranslated = entryTranslated .. ' (' .. choreEntry.desc .. ')'
                                    end

                                    self:AddEntry(entryTranslated, choreEntry, questsModule.quests[choreEntry.quest])
                                end
                            end
                        else
                            local bestState = nil
                            local bestEntry

                            for _, choreEntry in ipairs(choreData.entries) do
                                local entryState = questsModule.quests[choreEntry.quest]
                                if bestState == nil or bestState.status < entryState.status then
                                    bestEntry = choreEntry
                                    bestState = entryState
                                end
                            end

                            if Addon.db.profile.general.showCompleted or bestState.status < 2 then
                                self:AddEntry(translated, bestEntry, bestState)
                            end
                        end
                    end
                end
            end
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

function Module:AddEntry(translated, entry, state)

    local thingString = ''
    if entry.item ~= nil then
        local itemInfo = self.itemCache[entry.item] or {}

        if itemInfo.name == nil then
            itemInfo.name = C_Item.GetItemNameByID(entry.item)
        end
        if itemInfo.quality == nil then
            itemInfo.quality = C_Item.GetItemQualityByID(entry.item)
        end
        if itemInfo.texture == nil then
            itemInfo.texture = C_Item.GetItemIconByID(entry.item)
        end

        self.itemCache[entry.item] = itemInfo

        if itemInfo.name ~= nil and itemInfo.quality ~= nil and itemInfo.texture ~= nil then
            thingString = '|T' .. itemInfo.texture .. ':0|t ' ..
                ITEM_QUALITY_COLORS[itemInfo.quality].hex .. itemInfo.name .. '|r'
        else
            C_Item.RequestLoadItemDataByID(entry.item)
            self.itemRequested[entry.item] = true

            thingString = '|cFFFFFFFFItem #' .. entry.item .. '|r'
        end
    else
        thingString = '|cFFFFFFFF' .. QuestUtils_GetQuestName(entry.quest) .. '|r'
    end

    local text = CHORE_PREFIX[state.status] .. translated .. '|r: ' .. thingString
    self:AddLine(text)
end

function Module:AddLine(text)
    local fontString = table.remove(self.fsPool) or self.frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    fontString:SetText(text)
    fontString:SetFont(fontString:GetFont(), 13)

    if #self.fontStrings == 0 then
        fontString:SetPoint('TOPLEFT', self.frame, 'TOPLEFT', PADDING_OUTER, -PADDING_OUTER)
    else
        fontString:SetPoint('TOPLEFT', self.fontStrings[#self.fontStrings], 'BOTTOMLEFT', 0, -5)
    end

    fontString:Show()

    table.insert(self.fontStrings, fontString)
end
