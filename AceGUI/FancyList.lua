local AceGUI = LibStub('AceGUI-3.0')

--[[
	 xpcall safecall implementation
]]
local xpcall = xpcall

local function errorhandler(err)
	return geterrorhandler()(err)
end

local function safecall(func, ...)
	if func then
		return xpcall(func, errorhandler, ...)
	end
end

-- Based on 'List' layout
AceGUI:RegisterLayout('FancyList',
	function(content, children)
        local paddingX = content.paddingX or 0
        local paddingY = content.paddingY or 0
        local spacing = content.spacing or 0

		local height = paddingY
		local width = content.width or content:GetWidth() or 0

		local lastChild
        for _, child in ipairs(children) do
            local frame = child.frame
            frame:ClearAllPoints()
			frame:Show()
			
			if lastChild == nil then
				frame:SetPoint('TOPLEFT', content, paddingX, -paddingY)
			else
				frame:SetPoint('TOPLEFT', lastChild.frame, 'BOTTOMLEFT', 0, -spacing)
			end

			child:SetWidth(width - (2 * paddingX))
			frame:SetPoint('RIGHT', content, -paddingX, 0)

			if child.DoLayout then
				child:DoLayout()
			end

			height = height + (frame.height or frame:GetHeight() or 0) + spacing
			lastChild = child
		end

		safecall(content.obj.LayoutFinished, content.obj, nil, height)
	end)
