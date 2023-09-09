local AceGUI = LibStub('AceGUI-3.0')

-- Lua APIs
local pairs, assert, type = pairs, assert, type

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

----------------
-- Main Frame --
----------------
--[[
    Events :
        OnClose

]]
do
    local Type = 'ChoreFrame'
    local Version = 1

    local function frameOnShow(this)
        this.obj:Fire('OnShow')
    end

    local function frameOnClose(this)
        this.obj:Fire('OnClose')
    end

    local function frameOnMouseDown(this)
        this:StartMoving()
        AceGUI:ClearFocus()
    end

    local function frameOnMouseUp(this)
        this:StopMovingOrSizing()
        local self = this.obj
        local status = self.status or self.localstatus

        if self.status.minimized ~= true then
            status.height = this:GetHeight()
        end

        status.width = this:GetWidth()
        status.top = this:GetTop()
        status.left = this:GetLeft()
    end

    local function resizeButtonOnMouseDown(this)
        this:GetParent():StartSizing('BOTTOMRIGHT')
        AceGUI:ClearFocus()
    end

    local function resizeButtonOnMouseUp(this)
        frameOnMouseUp(this:GetParent())
        AceGUI:ClearFocus()
    end

    local function setDesaturation(button, desat)
        local texture = button:GetNormalTexture()
        texture:SetDesaturation(desat or 0.2)
    end

    local function setCollapseTexture(this)
        this.minMaxButton:SetNormalTexture([[Interface\Addons\ChoreTracker\Assets\collapse]])
        this.minMaxButton:SetHighlightTexture([[Interface\Addons\ChoreTracker\Assets\collapse]])
        setDesaturation(this.minMaxButton)
    end

    local function setExpandTexture(this)
        this.minMaxButton:SetNormalTexture([[Interface\Addons\ChoreTracker\Assets\expand]])
        this.minMaxButton:SetHighlightTexture([[Interface\Addons\ChoreTracker\Assets\expand]])
        setDesaturation(this.minMaxButton)
    end

    local function minMaxButtonOnClick(this)
        local self = this:GetParent().obj
        local status = self.status or self.localstatus
        status.minimized = (status.minimized ~= true)
        self:ApplyStatus()
    end

    local function Hide(self)
        self.frame:Hide()
    end

    local function Show(self)
        self.frame:Show()
    end

    local function OnAcquire(self)
        self.frame:SetParent(UIParent)
        self.frame:SetFrameStrata('LOW')
        self:ApplyStatus()
        self:EnableResize(true)
        self:Show()
    end

    local function OnRelease(self)
        self.status = nil
        for k in pairs(self.localstatus) do
            self.localstatus[k] = nil
        end
    end

    local function SetOptionsFrame(self, optionsFrame)
        self.optionsFrame = optionsFrame
    end

    -- called to set an external table to store status in
    local function SetStatusTable(self, status)
        assert(type(status) == 'table')
        self.status = status
        self:ApplyStatus()
    end

    local function ApplyStatus(self)
        local status = self.status or self.localstatus
        local frame = self.frame
        
        self:SetWidth(status.width or 200)
        if status.minimized then
            self:SetHeight(22)
        else
            self:SetHeight(status.height or 150)
        end
        
        frame:ClearAllPoints()
        if status.top and status.left then
            frame:SetPoint('TOP', UIParent, 'BOTTOM', 0, status.top)
            frame:SetPoint('LEFT', UIParent, 'LEFT', status.left, 0)
        else
            frame:SetPoint('CENTER', UIParent, 'CENTER')
        end

        if status.minimized then
            setExpandTexture(self)
            self.content:Hide()
            self.resizeButton:Hide()
        else
            setCollapseTexture(self)
            self.content:Show()
            self.resizeButton:Show()
        end
    end

    local function OnWidthSet(self, width)
        local content = self.content
        local contentwidth = width - 34
        if contentwidth < 0 then
            contentwidth = 0
        end
        content:SetWidth(contentwidth)
        content.width = contentwidth
    end


    local function OnHeightSet(self, height)
        local content = self.content
        local contentheight = height - 57
        if contentheight < 0 then
            contentheight = 0
        end
        content:SetHeight(contentheight)
        content.height = contentheight
    end

    local function EnableResize(self, state)
        -- local func = state and 'Show' or 'Hide'
        -- self.sizer_s[func](self.sizer_s)
        -- self.sizer_e[func](self.sizer_e)
    end

    local function Constructor()
        local frame = CreateFrame('Frame', nil, UIParent, 'BackdropTemplate')
        local self = {}
        self.type = 'ChoreFrame'

        self.Hide = Hide
        self.Show = Show
        self.OnRelease = OnRelease
        self.OnAcquire = OnAcquire
        self.SetOptionsFrame = SetOptionsFrame
        self.SetStatusTable = SetStatusTable
        self.ApplyStatus = ApplyStatus
        self.OnWidthSet = OnWidthSet
        self.OnHeightSet = OnHeightSet
        self.EnableResize = EnableResize

        self.localstatus = {}

        self.frame = frame
        frame.obj = self
        frame:SetWidth(1)
        frame:SetHeight(1)
        frame:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
        frame:EnableMouse()
        frame:SetMovable(true)
        frame:SetResizable(true)
        -- frame:SetFrameStrata('BACKGROUND')
        frame:SetScript('OnMouseDown', frameOnMouseDown)
        frame:SetScript('OnMouseUp', frameOnMouseUp)

        frame:SetScript('OnShow', frameOnShow)
        frame:SetScript('OnHide', frameOnClose)
        frame:SetResizeBounds(200, 150)
        -- frame:SetToplevel(true)

        frame:SetBackdrop({
            bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
            edgeFile = [[Interface\Buttons\WHITE8X8]],
            edgeSize = 1,
            tile = true,
            tileSize = 16,
        })
        frame:SetBackdropColor(0, 0, 0, 0.7)
        frame:SetBackdropBorderColor(63/255, 63/255, 63/255, 0.7)

        -- Title text
        local titleText = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
        titleText:SetJustifyH('LEFT')
        titleText:SetPoint('TOPLEFT', frame, 'TOPLEFT', 6, 0)
        titleText:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -35, -22)
        titleText:SetText('ChoreTracker')

        self.titleText = titleText

        -- Settings button
        local settingsButton = CreateFrame('Button', nil, frame)
        settingsButton.obj = frame
        settingsButton:SetPoint('TOPRIGHT', -2, -2)
        settingsButton:SetSize(16, 16)
        settingsButton:SetNormalTexture([[Interface\Addons\ChoreTracker\Assets\gear]])
        settingsButton:SetHighlightTexture([[Interface\Addons\ChoreTracker\Assets\gear]])
        setDesaturation(settingsButton)

        settingsButton:SetScript('OnClick', function() InterfaceOptionsFrame_OpenToCategory(self.optionsFrame) end)

        self.settingsButton = settingsButton

        -- Minimize/maximize button
        local minMaxButton = CreateFrame('Button', nil, frame)
        minMaxButton.obj = frame
        minMaxButton:SetPoint('TOPRIGHT', -20, -2)
        minMaxButton:SetSize(16, 16)

        minMaxButton:SetScript('OnClick', minMaxButtonOnClick)

        self.minMaxButton = minMaxButton

        -- Separator
        local separator = frame:CreateLine()
        separator:SetColorTexture(63 / 255, 63 / 255, 63 / 255, 0.7)
        separator:SetStartPoint('TOPLEFT', 0, -21)
        separator:SetEndPoint('TOPRIGHT', 0, -21)
        separator:SetThickness(1)

        self.separator = separator

        -- Resize thing in the bottom right
        local resizeButton = CreateFrame('Button', nil, frame)
        resizeButton:SetPoint('BOTTOMRIGHT', 0, 0)
        resizeButton:SetSize(16, 16)
        resizeButton:SetNormalTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Up]])
        resizeButton:SetHighlightTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Highlight]])
        resizeButton:SetPushedTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Down]])

        resizeButton:SetScript('OnMouseDown', resizeButtonOnMouseDown)
        resizeButton:SetScript('OnMouseUp', resizeButtonOnMouseUp)

        self.resizeButton = resizeButton

        -- Container Support
        local content = CreateFrame('Frame', nil, frame)--, 'BackdropTemplate')
        self.content = content
        content.obj = self
        content:SetPoint('TOPLEFT', frame, 'TOPLEFT', 1, -22)
        content:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -2, 13)

        AceGUI:RegisterAsContainer(self)
        return self
    end

    AceGUI:RegisterWidgetType(Type, Constructor, Version)
end
