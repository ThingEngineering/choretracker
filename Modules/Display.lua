local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Display')


function Module:OnInitialize()
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
    frame:SetHeight(200)
    frame:SetWidth(400)
    frame:SetPoint('TOPLEFT', 100, -100)

    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag('LeftButton')
    frame:SetScript('OnDragStart', self.OnDragStart)
    frame:SetScript('OnDragStop', self.OnDragStop)

    local text = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    text:SetPoint('TOPLEFT', frame, 'TOPLEFT')
    text:SetText('HI MUM')

    self.frame = frame

    print('I DONE IT')
end

function Module:OnEnteringWorld()
    self.frame:Show()
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
