local AceGUI = LibStub('AceGUI-3.0')

local BUTTON_SIZE = 16
local SPACING = 5

AceGUI:RegisterLayout('LabelWithButton',
    function(content, children)
		local width = content:GetWidth() or 0

        local labelWidth = width - BUTTON_SIZE - SPACING
        if labelWidth < 0 then labelWidth = 0 end

        local label = children[1]
        local button = children[2]

        if label then
            label:SetWidth(labelWidth)
            label.frame:ClearAllPoints()
            label.frame:SetPoint('TOPLEFT', content, 'TOPLEFT', 0, 0)
        end

        if button then
            button:SetHeight(BUTTON_SIZE)
            button:SetWidth(BUTTON_SIZE)
            button.frame:ClearAllPoints()
            button.frame:SetPoint('TOPRIGHT', content, 'TOPRIGHT', 0, 6)
        end

        content:SetHeight(BUTTON_SIZE + 5)
    end
)
