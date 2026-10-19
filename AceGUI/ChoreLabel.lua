local AceGUI = LibStub('AceGUI-3.0')
local Type, Version = 'ChoreLabel', 1

local parentType = 'Label' -- Inherit from this
local parentProto = AceGUI.WidgetRegistry[parentType]

local function Constructor()
    local widget = parentProto()
    widget.type = Type

    local baseOnAcquire = widget.OnAcquire
    widget.OnAcquire = function(self)
        baseOnAcquire(self)
        self.label:SetWordWrap(false)
    end

    return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
