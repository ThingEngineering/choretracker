local addonName, Addon = ...
local L = Addon.L
local Module = Addon:NewModule('Options')

local AC = LibStub('AceConfig-3.0')
local ACD = LibStub('AceConfigDialog-3.0')
local ADBO = LibStub('AceDBOptions-3.0')
local LSM = LibStub('LibSharedMedia-3.0')


local WIDTH_3_PER_ROW = 1.1
local WIDTH_4_PER_ROW = 0.81

local ALL_SECTIONS = {
    'anniversary',
    'delves',
    'dragonflight',
    'events',
    'professions',
    'pvp',
    'timers',
    'warWithin',
}

local FONT_FLAGS = {
    [''] = 'None',
    ['MONOCHROME'] = 'Monochrome',
    ['MONOCHROME,OUTLINE'] = 'Monochrome, Outline',
    ['MONOCHROME,THICKOUTLINE'] = 'Monochrome, Thick Outline',
    ['OUTLINE'] = 'Outline',
    ['THICKOUTLINE'] = 'Thick Outline'
}

local OBJECTIVES = {
    ['ALL'] = 'All',
    ['INCOMPLETE'] = 'Incomplete',
    ['NONE'] = 'None',
}

local STRATA = {
    ['BACKGROUND'] = 'Background',
    ['LOW'] = 'Low',
    ['MEDIUM'] = 'Medium',
    ['HIGH'] = 'High',
}
local STRATA_ORDER = { 'BACKGROUND', 'LOW', 'MEDIUM', 'HIGH' }

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

function Module:GetOption(info)
    local sigh = self:GetDbSection(info[1])
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
end

function Module:SetOption(info, value)
    local sigh = self:GetDbSection(info[1])
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

    if sigh == nil then
        print('womp womp')
        for i = 1, #info do
            print(i .. ': ' .. info[i])
        end
    end

    self:SendMessage('ChoreTracker_Config_Changed')
end

function Module:GetDbSection(sighKey)
    if sighKey == 'sectionChores' or sighKey == 'sectionProfessions' then
        sighKey = 'chores'
    elseif sighKey == 'sectionDelves' then
        sighKey = 'delves'
    elseif sighKey == 'sectionTimers' then
        sighKey = 'timers'
    end

    return Addon.db.profile[sighKey]
end

function Module:SetAllChores(sectionKey, onlyCategory, value)
    local section = Addon.data.chores[sectionKey]
    for _, category in ipairs(section.categories) do
        if onlyCategory == nil or category.key == onlyCategory then
            local categoryOptions = Addon.db.profile.chores[sectionKey][category.key]
            if categoryOptions == nil then
                categoryOptions = {}
                Addon.db.profile.chores[sectionKey][category.key] = categoryOptions
            end

            for _, typeKey in ipairs({ 'drops', 'quests' }) do
                if category[typeKey] ~= nil then
                    local typeOptions = categoryOptions[typeKey]
                    if typeOptions == nil then
                        typeOptions = {}
                        categoryOptions[typeKey] = typeOptions
                    end
            
                    for _, chore in ipairs(category[typeKey]) do
                        typeOptions[chore.key] = value
                    end
                end
            end
        end
    end
end

function Module:DisableChores(sectionKey, onlyCategory)
    self:SetAllChores(sectionKey, onlyCategory, false)
end

function Module:EnableChores(sectionKey, onlyCategory)
    self:SetAllChores(sectionKey, onlyCategory, true)
end

function Module:CreateOptions()
    self.options = {
        name = addonName,
        type = 'group',
        childGroups = 'tab',
        handler = self,
        get = 'GetOption',
        set = 'SetOption',
        args = {
            general = {
                name = L['section:general'],
                type = 'group',
                order = newOrder(),
                args = {
                    bulk = {
                        name = L['option:bulkActions'],
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            disableDragonflight = {
                                name = L['option:bulkActions:dragonflightDisable'],
                                type = 'execute',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                                func = function()
                                    self:DisableChores('choresDragonflight')
                                    for sectionKey, _ in pairs(Addon.data.chores) do
                                        if sectionKey:find('^profession') then
                                            self:DisableChores(sectionKey, 'dragonflight')
                                        end
                                    end
                                    print('Disabled ALL Dragonflight chores!')
                                end,
                            },
                            enableDragonflight = {
                                name = L['option:bulkActions:dragonflightEnable'],
                                type = 'execute',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                                func = function()
                                    self:EnableChores('choresDragonflight')
                                    for sectionKey, _ in pairs(Addon.data.chores) do
                                        if sectionKey:find('^profession') then
                                            self:EnableChores(sectionKey, 'dragonflight')
                                        end
                                    end
                                    print('Enabled ALL Dragonflight chores!')
                                end,
                            },
                        }
                    },
                    display = {
                        name = L['option:display'],
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            showCompletedSections = {
                                name = L['option:display:showCompletedSections'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                            },
                            showCompleted = {
                                name = L['option:display:showCompleted'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                            },
                            statusIcons = {
                                name = L['option:display:statusIcons'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                            },
                            showAnniversaryAccount = {
                                name = L['option:display:showAnniversaryAccount'],
                                type = 'toggle',
                                order = newOrder(),
                                width = 2.2,
                            },
                            showObjectives = {
                                name = L['option:display:showObjectives'],
                                type = 'select',
                                order = newOrder(),
                                values = OBJECTIVES,
                                -- sorting = STRATA_ORDER,
                            },
                        },
                    },
                    order = {
                        name = L['option:sectionOrder'],
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = self:GetSectionOrderOptions(),
                    },
                    appearance = {
                        name = L['option:appearance'],
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            backgroundColor = {
                                name = L['option:appearance:backgroundColor'],
                                type = 'color',
                                order = newOrder(),
                                hasAlpha = true,
                                get = function()
                                    local color = Addon.db.profile.general.appearance.backgroundColor
                                    return color.r, color.g, color.b, color.a
                                end,
                                set = function(_, r, g, b, a)
                                    local color = Addon.db.profile.general.appearance.backgroundColor
                                    color.r = r
                                    color.g = g
                                    color.b = b
                                    color.a = a
                                    self:SendMessage('ChoreTracker_Config_Changed')
                                end,
                            },
                            borderColor = {
                                name = L['option:appearance:borderColor'],
                                type = 'color',
                                order = newOrder(),
                                hasAlpha = true,
                                get = function()
                                    local color = Addon.db.profile.general.appearance.borderColor
                                    return color.r, color.g, color.b, color.a
                                end,
                                set = function(_, r, g, b, a)
                                    local color = Addon.db.profile.general.appearance.borderColor
                                    color.r = r
                                    color.g = g
                                    color.b = b
                                    color.a = a
                                    self:SendMessage('ChoreTracker_Config_Changed')
                                end,
                            },
                            strata = {
                                name = L['option:appearance:strata'],
                                type = 'select',
                                order = newOrder(),
                                values = STRATA,
                                sorting = STRATA_ORDER,
                            },
                        },
                    },
                    text = {
                        name = L['option:text'],
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            font = {
                                name = L['option:text:font'],
                                type = 'select',
                                order = newOrder(),
                                dialogControl = 'LSM30_Font',
                                values = LSM:HashTable('font'),
                            },
                            fontSize = {
                                name = L['option:text:fontSize'],
                                type = 'range',
                                order = newOrder(),
                                min = 8,
                                max = 24,
                                step = 1,
                            },
                            fontStyle = {
                                name = L['option:text:fontStyle'],
                                type = 'select',
                                order = newOrder(),
                                values = FONT_FLAGS,
                            },
                        },
                    },
                    automation = {
                        name = L['option:automation'],
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            acceptQuests = {
                                name = L['option:automation:acceptQuests'],
                                desc = L['option:automation:acceptQuests:desc'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                            },
                        },
                    }
                }
            },
            sectionChores = {
                name = L['section:chores'],
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    choresWarWithin = self:GetChoreOptions(Addon.data.chores.choresWarWithin, WIDTH_3_PER_ROW, true),
                    choresHallowfallFishingDerby = self:GetChoreOptions(Addon.data.chores.choresHallowfallFishingDerby, WIDTH_3_PER_ROW, true),
                    choresAnniversary = self:GetChoreOptions(Addon.data.chores.choresAnniversary, WIDTH_3_PER_ROW, true),
                    choresEvents = self:GetChoreOptions(Addon.data.chores.choresEvents, WIDTH_3_PER_ROW, true),
                    choresPvp = self:GetChoreOptions(Addon.data.chores.choresPvp, WIDTH_3_PER_ROW, true),
                    choresDragonflight = self:GetChoreOptions(Addon.data.chores.choresDragonflight, WIDTH_3_PER_ROW, true),
                },
            },
            sectionDelves = {
                name = L['section:delves'],
                type = 'group',
                order = newOrder(),
                args = {
                    bountiful = {
                        name = L['option:bountifulDelves'],
                        type = 'group',
                        inline = true,
                        order = newOrder(),
                        args = {
                            showDelves = {
                                name = L['option:bountifulDelves:showDelves'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                            },
                            showKeys = {
                                name = L['option:bountifulDelves:showKeys'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                            },
                            onlyWithKeys = {
                                name = L['option:bountifulDelves:onlyWithKeys'],
                                type = 'toggle',
                                order = newOrder(),
                                width = WIDTH_3_PER_ROW,
                            },
                        },
                    },
                },
            },
            sectionProfessions = {
                name = L['section:professions'],
                type = 'group',
                childGroups = 'tab',
                order = newOrder(),
                args = {
                    professionAlchemy = self:GetChoreOptions(Addon.data.chores.professionAlchemy),
                    professionBlacksmithing = self:GetChoreOptions(Addon.data.chores.professionBlacksmithing),
                    professionEnchanting = self:GetChoreOptions(Addon.data.chores.professionEnchanting),
                    professionEngineering = self:GetChoreOptions(Addon.data.chores.professionEngineering),
                    professionInscription = self:GetChoreOptions(Addon.data.chores.professionInscription),
                    professionJewelcrafting = self:GetChoreOptions(Addon.data.chores.professionJewelcrafting),
                    professionLeatherworking = self:GetChoreOptions(Addon.data.chores.professionLeatherworking),
                    professionTailoring = self:GetChoreOptions(Addon.data.chores.professionTailoring),
                    professionHerbalism = self:GetChoreOptions(Addon.data.chores.professionHerbalism),
                    professionMining = self:GetChoreOptions(Addon.data.chores.professionMining),
                    professionSkinning = self:GetChoreOptions(Addon.data.chores.professionSkinning),
                    professionArchaeology = self:GetChoreOptions(Addon.data.chores.professionArchaeology),
                    professionCooking = self:GetChoreOptions(Addon.data.chores.professionCooking),
                    professionFishing = self:GetChoreOptions(Addon.data.chores.professionFishing),
                }
            },
            sectionTimers = {
                name = L['section:timers'],
                type = 'group',
                order = newOrder(),
                args = {
                    warWithin = self:GetTimerOptions(Addon.data.timers.warWithin),
                    dragonflight = self:GetTimerOptions(Addon.data.timers.dragonflight),
                },
            },
        },
    }
end

function Module:GetChoreOptions(data, optionWidth, inline)
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

        for _, key in ipairs({ 'drops', 'dungeons', 'quests' }) do
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

function Module:GetSectionOrderOptions()
    local args = {}
    local numSections = #ALL_SECTIONS

    for i, section in ipairs(Addon.db.profile.general.order.sections) do
        args['section'..i] = {
            name = L['section:'..section],
            type = 'description',
            width = 'normal',
            fontSize = 'medium',
            order = newOrder(),
        }
        args['section'..i..'up'] = {
            name = (i > 1) and 'Up' or ' ',
            -- desc = 'text',
            type = (i > 1) and 'execute' or 'description',
            width = 'half',
            func = function() self:MoveSection(i, 'up') end,
            order = newOrder(),
        }
        args['section'..i..'down'] = {
            name = (i < numSections) and 'Down' or ' ',
            -- desc = 'text',
            type = (i < numSections) and 'execute' or 'description',
            width = 'half',
            func = function() self:MoveSection(i, 'down') end,
            order = newOrder(),
        }
        args["section"..i.."padding"] = {
            name = '',
            type = 'description',
            width = 'normal',
            fontSize = 'medium',
            order = newOrder(),
        }
    end

    return args
end

function Module:MoveSection(index, direction)
    local sections = Addon.db.profile.general.order.sections
    local key = tremove(sections, index)

    if direction == 'up' then
        tinsert(sections, index - 1, key)
    else
        tinsert(sections, index + 1, key)
    end

    self.options.args.general.args.order.args = self:GetSectionOrderOptions()
    self:SendMessage('ChoreTracker_Config_Changed')
end

function Module:GetTimerOptions(data)
    local options = {
        name = data.name or L[data.key],
        type = 'group',
        inline = true,
        order = newOrder(),
        args = {},
    }

    for _, timer in ipairs(data.timers) do
        options.args[timer.key] = {
            name = L['timer:' .. timer.key],
            type = 'toggle',
            order = newOrder(),
            width = WIDTH_3_PER_ROW,
        }
    end

    return options
end
