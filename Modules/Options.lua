local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Options')

local AC = LibStub('AceConfig-3.0')
local ACD = LibStub('AceConfigDialog-3.0')
local ADBO = LibStub('AceDBOptions-3.0')
local LSM = LibStub('LibSharedMedia-3.0')


local WIDTH_3_PER_ROW = 1.1
local WIDTH_4_PER_ROW = 0.81

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
                                width = WIDTH_3_PER_ROW,
                            },
                            statusIcons = {
                                name = L['option:general:statusIcons'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
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
                    choresDragonflight = self:GetDataOptions(Addon.data.chores.choresDragonflight, WIDTH_3_PER_ROW, true),
                    choresEvents = self:GetDataOptions(Addon.data.chores.choresEvents, WIDTH_3_PER_ROW, true),
                },
            },
            sectionProfessions = {
                name = 'Professions',
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    professionAlchemy = self:GetDataOptions(Addon.data.chores.professionAlchemy),
                    professionBlacksmithing = self:GetDataOptions(Addon.data.chores.professionBlacksmithing),
                    professionEnchanting = self:GetDataOptions(Addon.data.chores.professionEnchanting),
                    professionEngineering = self:GetDataOptions(Addon.data.chores.professionEngineering),
                    professionInscription = self:GetDataOptions(Addon.data.chores.professionInscription),
                    professionJewelcrafting = self:GetDataOptions(Addon.data.chores.professionJewelcrafting),
                    professionLeatherworking = self:GetDataOptions(Addon.data.chores.professionLeatherworking),
                    professionTailoring = self:GetDataOptions(Addon.data.chores.professionTailoring),
                    professionHerbalism = self:GetDataOptions(Addon.data.chores.professionHerbalism),
                    professionMining = self:GetDataOptions(Addon.data.chores.professionMining),
                    professionSkinning = self:GetDataOptions(Addon.data.chores.professionSkinning),
                    professionArchaeology = self:GetDataOptions(Addon.data.chores.professionArchaeology),
                    professionCooking = self:GetDataOptions(Addon.data.chores.professionCooking),
                    professionFishing = self:GetDataOptions(Addon.data.chores.professionFishing),
                }
            }
        }
    }
end

function Module:GetDataOptions(data, optionWidth, inline)
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
        local catOptions
        local parentKey = data.key .. ':' .. catData.key
        
        if inline == true then
            catOptions = options
            parentKey = data.key

            options.args[catData.key .. ':header'] = {
                name = catData.name or L['category:' .. catData.key],
                type = 'header',
                order = newOrder(),
            }
        else
            catOptions = {
                name = catData.name or L['category:' .. catData.key],
                type = 'group',
                order = newOrder(),
                inline = true,
                args = {},
            }
            options.args[catData.key] = catOptions
            parentKey = data.key .. ':' .. catData.key
        end

        for _, key in ipairs({ 'drops', 'quests' }) do
            if catData[key] ~= nil then
                local thisKey
                if inline == true then
                    thisKey = catData.key .. ':' .. key
                else
                    catOptions.args[key .. ':header'] = {
                        name = L['section:' .. key],
                        type = 'header',
                        order = newOrder(),
                    }
                    thisKey = key
                end

                self:AddSubOptions(
                    catOptions,
                    parentKey,
                    thisKey,
                    catData[key],
                    optionWidth or WIDTH_4_PER_ROW
                )
            end
        end
    end

    return options
end

function Module:AddSubOptions(optionsTable, parentKey, key, data, optionWidth)
    if #data == 0 then return end

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
