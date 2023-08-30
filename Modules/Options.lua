local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Options')

local AC = LibStub('AceConfig-3.0')
local ACD = LibStub('AceConfigDialog-3.0')
local ADBO = LibStub('AceDBOptions-3.0')


local newOrder
do
	local current = 0
	function newOrder()
		current = current + 1
		return current
	end
end

function Module:OnInitialize()
    self:CreateOptions()

    AC:RegisterOptionsTable(addonName, self.options)
    self.optionsFrame = ACD:AddToBlizOptions(addonName, addonName)

    local profileOptions = ADBO:GetOptionsTable(Addon.db)
    AC:RegisterOptionsTable(addonName .. '_Profiles', profileOptions)
    ACD:AddToBlizOptions(addonName .. '_Profiles', 'Profiles', addonName)
end

function Module:CreateOptions()
    self.options = {
        name = addonName,
        type = 'group',
        childGroups = 'tab',
        get = function(info)
            local sigh = Addon.db.profile[info[1]]
            for i = 2, #info do
                if sigh == nil then break end
                
                local parts = { strsplit('_', info[i]) }
                for _, part in ipairs(parts) do
                    sigh = sigh[part]
                    if sigh == nil then break end
                end
            end
            return sigh
        end,
        set = function(info, value)
            local sigh = Addon.db.profile[info[1]]
            for i = 2, #info do
                if sigh == nil then break end

                local parts = { strsplit('_', info[i]) }
                for j, part in ipairs(parts) do
                    if i == #info and j == #parts then
                        sigh[part] = value
                    else
                        sigh = sigh[part]
                    end
                    if sigh == nil then break end
                end
            end
            self:SendMessage('ChoreTracker_Config_Changed')
        end,
        args = {
            general = {
                name = 'General',
                type = 'group',
                order = newOrder(),
                args = {
                    showCompleted = {
                        name = L['section_general_showCompleted'],
                        type = 'toggle',
                        order = newOrder(),
                        -- width = 0.8,
                    }
                }
            },
            professions = {
                name = 'Professions',
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    alchemy = self:GetProfessionOptions('alchemy'),
                    blacksmithing = self:GetProfessionOptions('blacksmithing'),
                    enchanting = self:GetProfessionOptions('enchanting'),
                    engineering = self:GetProfessionOptions('engineering'),
                    inscription = self:GetProfessionOptions('inscription'),
                    jewelcrafting = self:GetProfessionOptions('jewelcrafting'),
                    leatherworking = self:GetProfessionOptions('leatherworking'),
                    tailoring = self:GetProfessionOptions('tailoring'),
                    herbalism = self:GetProfessionOptions('herbalism'),
                    mining = self:GetProfessionOptions('mining'),
                    skinning = self:GetProfessionOptions('skinning'),
                }
            }
        }
    }
end

function Module:GetProfessionOptions(key)
    local data = Addon.data.professions[key]
    local options = {
        name = C_TradeSkillUI.GetTradeSkillDisplayName(data.skillLineId),
        type = 'group',
        order = newOrder(),
        args = {},
    }

    for expansionKey, expansionData in pairs(data.expansions) do
        local expansionOptions = {
            name = expansionData.name,
            type = 'group',
            order = newOrder(),
            inline = true,
            args = {},
        }
        
        self:AddProfessionSubOptions(expansionOptions, 'drops', expansionData.drops)
        self:AddProfessionSubOptions(expansionOptions, 'quests', expansionData.quests)
    
        options.args[expansionKey] = expansionOptions
    end

    return options
end

function Module:AddProfessionSubOptions(optionsTable, key, data)
    if #data == 0 then return end

    optionsTable.args[key] = {
        name = L['section_' .. key],
        type = 'header',
        order = newOrder(),
    }

    for _, subData in ipairs(data) do
        local subKey = key .. '_' .. subData.key
        optionsTable.args[subKey] = {
            name = L['section_' .. subKey],
            type = 'toggle',
            order = newOrder(),
            width = 0.8,
        }
    end
end