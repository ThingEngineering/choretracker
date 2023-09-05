local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Options')

local AC = LibStub('AceConfig-3.0')
local ACD = LibStub('AceConfigDialog-3.0')
local ADBO = LibStub('AceDBOptions-3.0')
local LSM = LibStub('LibSharedMedia-3.0')


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
            local sigh = Addon.db.profile[info[1]:match('^section') and 'chores' or info[1]]
            for i = 2, #info do
                if sigh == nil then break end
                local parts = { strsplit(':', info[i]) }
                for _, part in ipairs(parts) do
                    sigh = sigh[part]
                    if sigh == nil then break end
                end
            end
            if sigh == nil then
                print('womp womp')
                for i = 1, #info do
                    print(i .. ': ' .. info[i])
                end
            end
            return sigh
        end,
        set = function(info, value)
            local sigh = Addon.db.profile[info[1]:match('^section') and 'chores' or info[1]]
            for i = 2, #info do
                if sigh == nil then break end
                local parts = { strsplit(':', info[i]) }
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
                    display = {
                        name = 'Display',
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            showCompleted = {
                                name = L['option:general:showCompleted'],
                                type = 'toggle',
                                order = newOrder(),
                                -- width = 0.8,
                            },
                            statusIcons = {
                                name = L['option:general:statusIcons'],
                                type = 'toggle',
                                order = newOrder(),
                            },
                        },
                    },
                    text = {
                        name = 'Text',
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            font = {
                                name = 'Font',
                                type = 'select',
                                width = 1.2,
                                dialogControl = 'LSM30_Font',
                                values = LSM:HashTable('font'),
                            },
                            fontSize = {
                                name = 'Font size',
                                type = 'range',
                                min = 8,
                                max = 24,
                                step = 1,
                            },
                        },
                    },
                }
            },
            sectionChores = {
                name = 'Chores',
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    choresDragonflight = self:GetDataOptions(Addon.data.choresDragonflight, 1.1),
                    choresEvents = self:GetDataOptions(Addon.data.choresEvents, 1.1),
                },
            },
            sectionProfessions = {
                name = 'Professions',
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    professionAlchemy = self:GetDataOptions(Addon.data.professionAlchemy),
                    professionBlacksmithing = self:GetDataOptions(Addon.data.professionBlacksmithing),
                    professionEnchanting = self:GetDataOptions(Addon.data.professionEnchanting),
                    professionEngineering = self:GetDataOptions(Addon.data.professionEngineering),
                    professionInscription = self:GetDataOptions(Addon.data.professionInscription),
                    professionJewelcrafting = self:GetDataOptions(Addon.data.professionJewelcrafting),
                    professionLeatherworking = self:GetDataOptions(Addon.data.professionLeatherworking),
                    professionTailoring = self:GetDataOptions(Addon.data.professionTailoring),
                    professionHerbalism = self:GetDataOptions(Addon.data.professionHerbalism),
                    professionMining = self:GetDataOptions(Addon.data.professionMining),
                    professionSkinning = self:GetDataOptions(Addon.data.professionSkinning),
                    professionArchaeology = self:GetDataOptions(Addon.data.professionArchaeology),
                    professionCooking = self:GetDataOptions(Addon.data.professionCooking),
                    professionFishing = self:GetDataOptions(Addon.data.professionFishing),
                }
            }
        }
    }
end

function Module:GetDataOptions(data, optionWidth)
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

    for _, catData in ipairs(data.categories or {}) do
        local catOptions = {
            name = catData.name or L['category:' .. catData.key],
            type = 'group',
            order = newOrder(),
            inline = true,
            args = {},
        }

        for _, key in ipairs({ 'drops', 'quests' }) do
            if catData[key] ~= nil then
                self:AddSubOptions(catOptions, data.key .. ':' .. catData.key, key, catData[key], optionWidth or 0.8)
            end
        end

        options.args[catData.key] = catOptions
    end

    return options
end

function Module:AddSubOptions(optionsTable, parentKey, key, data, optionWidth)
    if #data == 0 then return end

    optionsTable.args[key] = {
        name = L['section:' .. key],
        type = 'header',
        order = newOrder(),
    }

    for _, subData in ipairs(data) do
        local subKey = key .. ':' .. subData.key
        optionsTable.args[subKey] = {
            name = L['chore:' .. parentKey .. ':' .. subKey],
            type = 'toggle',
            order = newOrder(),
            width = optionWidth,
        }
    end
end
