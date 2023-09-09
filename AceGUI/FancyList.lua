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

-- Based on "List" layout
AceGUI:RegisterLayout("FancyList",
	function(content, children)
        local paddingX = content.paddingX or 0
        local paddingY = content.paddingY or 0
        local spacing = content.spacing or 0

		local height = paddingY
		local width = content.width or content:GetWidth() or 0

        for i = 1, #children do
			local child = children[i]

			local frame = child.frame
			frame:ClearAllPoints()
            frame:Show()
			if i == 1 then
				frame:SetPoint("TOPLEFT", content, paddingX, -paddingY)
			else
				frame:SetPoint("TOPLEFT", children[i - 1].frame, "BOTTOMLEFT", 0, -spacing)
			end

			if child.width == "fill" then
				child:SetWidth(width - (2 * paddingX))
				frame:SetPoint("RIGHT", content, -paddingX, 0)

				if child.DoLayout then
					child:DoLayout()
				end
			elseif child.width == "relative" then
				child:SetWidth(width * child.relWidth)

				if child.DoLayout then
					child:DoLayout()
				end
			end

            height = height + (frame.height or frame:GetHeight() or 0) + spacing
		end
		safecall(content.obj.LayoutFinished, content.obj, nil, height)
	end)
