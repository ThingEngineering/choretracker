local Addon = LibStub('AceAddon-3.0'):GetAddon('ChoreTracker')
local Module = Addon:NewModule('Options')

local AC = LibStub('AceConfig-3.0')
local ACD = LibStub('AceConfigDialog-3.0')


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

    AC:RegisterOptionsTable('ChoreTracker', self.options)
    self.optionsFrame = ACD:AddToBlizOptions('ChoreTracker', 'ChoreTracker')
end

function Module:CreateOptions()
    self.options = {
        name = 'ChoreTracker',
        type = 'group',
        childGroups = 'tab',
        get = function(info)
            local sigh = Addon.db.profile[info[1]]
            for i = 2, #info do
                if sigh == nil then break end
                sigh = sigh[info[i]]
            end
            return sigh
        end,
        set = function(info, value)
            print('-- SET --')
            DevTools_Dump(info)

            local sigh = Addon.db.profile[info[1]]
            for i = 2, #info do
                if sigh == nil then break end
                if i == #info then
                    sigh[info[i]] = value
                else
                    sigh = sigh[info[i]]
                end
            end
        end,
        args = {
            professions = {
                name = 'Professions',
                type = 'group',
                order = newOrder(),
                args = {
                    alchemy = self:GetProfessionOptions('Alchemy', 'craft'),
                    blacksmithing = self:GetProfessionOptions('Blacksmithing', 'craft', true),
                    enchanting = self:GetProfessionOptions('Enchanting', 'craft'),
                    engineering = self:GetProfessionOptions('Engineering', 'craft', true),
                    inscription = self:GetProfessionOptions('Inscription', 'craft', true),
                    jewelcrafting = self:GetProfessionOptions('Jewelcrafting', 'craft', true),
                    leatherworking = self:GetProfessionOptions('Leatherworking', 'craft', true),
                    tailoring = self:GetProfessionOptions('Tailoring', 'craft', true),
                }
            }
        }
    }
end

function Module:GetProfessionOptions(name, type, hasOrders)
    local options = {
        name = name,
        type = 'group',
        order = newOrder(),
        inline = true,
        args = {},
    }

    if type == 'craft' then
        options.args = {
            dropTreasure = {
                name = 'Drops (treasures)',
                desc = 'Make sure you have some shovels!',
                type = 'toggle',
                order = newOrder(),
            },
            dropMob = {
                name = 'Drops (mobs)',
                desc = 'wibbly wobbly',
                type = 'toggle',
                order = newOrder(),
            },
            dropForbiddenReach = {
                name = 'Drop (Forbidden Reach)',
                desc = 'Drop from the summonable profession rare',
                type = 'toggle',
                order = newOrder(),
            },
            questCraft = {
                name = 'Craft quest',
                desc = 'Craft N thingies',
                type = 'toggle',
                order = newOrder(),
            },
            questGather = {
                name = 'Gather quest',
                desc = 'Gather N widgets',
                type = 'toggle',
                order = newOrder(),
            },
        }

        if hasOrders == true then
            options.args.questOrder = {
                name = 'Orders quest',
                desc = 'Complete N crafting orders',
                type = 'toggle',
                order = newOrder(),
            }
        end
    end

    return options
end
