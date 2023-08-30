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
                        name = L['option:general:showCompleted'],
                        type = 'toggle',
                        order = newOrder(),
                        -- width = 0.8,
                    }
                }
            },
            chores = {
                name = 'Chores',
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    dragonflight = self:GetDataOptions(Addon.data.choresDragonflight),
                },
            },
            professions = {
                name = 'Professions',
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    alchemy = self:GetDataOptions(Addon.data.professionAlchemy),
                    blacksmithing = self:GetDataOptions(Addon.data.professionBlacksmithing),
                    enchanting = self:GetDataOptions(Addon.data.professionEnchanting),
                    engineering = self:GetDataOptions(Addon.data.professionEngineering),
                    inscription = self:GetDataOptions(Addon.data.professionInscription),
                    jewelcrafting = self:GetDataOptions(Addon.data.professionJewelcrafting),
                    leatherworking = self:GetDataOptions(Addon.data.professionLeatherworking),
                    tailoring = self:GetDataOptions(Addon.data.professionTailoring),
                    herbalism = self:GetDataOptions(Addon.data.professionHerbalism),
                    mining = self:GetDataOptions(Addon.data.professionMining),
                    skinning = self:GetDataOptions(Addon.data.professionSkinning),
                }
            }
        }
    }
end

function Module:GetDataOptions(data)
    local options = {
        type = 'group',
        order = newOrder(),
        args = {},
    }
    if data.skillLineId ~= nil then
        options.name = C_TradeSkillUI.GetTradeSkillDisplayName(data.skillLineId)
    else
        options.name = data.name or L[data.key]
    end

    for _, catData in ipairs(data.categories) do
        local catOptions = {
            name = catData.name or L['category:' .. catData.key],
            type = 'group',
            order = newOrder(),
            inline = true,
            args = {},
        }
        
        for _, key in ipairs({ 'drops', 'quests' }) do
            if catData[key] ~= nil then
                self:AddSubOptions(catOptions, catData.key, key, catData[key])
            end
        end
    
        options.args[catData.key] = catOptions
    end

    return options
end

function Module:AddSubOptions(optionsTable, parentKey, key, data)
    if #data == 0 then return end

    optionsTable.args[key] = {
        name = L['section:' .. key],
        type = 'header',
        order = newOrder(),
    }

    for _, subData in ipairs(data) do
        local subKey = parentKey .. ':' .. key .. ':' .. subData.key
        optionsTable.args[subKey] = {
            name = L['chore:' .. subKey],
            type = 'toggle',
            order = newOrder(),
            width = 0.8,
        }
    end
end
