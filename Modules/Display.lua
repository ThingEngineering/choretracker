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
    frame:SetBackdropColor(0, 0, 0, 0.8)
    frame:SetBackdropBorderColor(32/255, 32/255, 32/255, 0.8)
    frame:SetFrameStrata('MEDIUM')
    frame:SetHeight(200)
    frame:SetWidth(400)
    frame:SetPoint('TOPLEFT', 100, -100)

    local text = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    text:SetPoint('CENTER')
    text:SetText('HI MUM')

    self.frame = frame

    print('I DONE IT')
end

function Module:OnEnteringWorld()
    self.frame:Show()
end
