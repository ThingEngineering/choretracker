local _, Addon = ...
local L = Addon.L


Addon.data.professionEngineering = {
    key = 'professions',
    order = 103,
    skillLineId = 202,
    texture = GetSpellTexture(4036),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2827,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70516, item=198969, desc='Keeper' }, -- Keeper's Mark
                        { quest=70517, item=198970, desc='Dragonkin' }, -- Infinitely Attachable Pair o' Docks
                    },
                },
                {
                    key = 'treasure',
                    entries = {
                        { quest=66379, item=193902 }, -- Eroded Titan Gizmo
                        { quest=66380, item=193903 }, -- Watcher Power Core
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74934, item=204227, level=70, desc='Fimbol' }, -- Everflowing Antifreeze
                    },
                },
            },
            quests = {
                {
                    key = 'craft',
                    entries = {
                        { quest=70539 }, -- And You Thought They Did Nothing
                        { quest=70540 }, -- An Engineer's Best Friend
                        { quest=70545 }, -- Blingtron 8000...?
                        { quest=70557 }, -- No Scopes
                    },
                },
                {
                    key = 'gather',
                    entries = {
                        { quest=66890 }, -- Stolen Tools
                        { quest=66891 }, -- Explosive Ash
                        { quest=66942 }, -- Enemy Engineering
                        { quest=72396 }, -- Horns of Plenty
                        { quest=75575, level=70 }, -- Ballistae Bits [ZC]
                        { quest=75608, level=70 }, -- Titan Trash or Titan Treasure [ZC]
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=70591 }, -- Engineering Services Requested
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74111, item=198510 }, -- Draconic Treatise on Engineering
                    },
                },
            },
        },
        {
            key = 'event',
            name = L['category:event'],
            requiredEventId = 479, -- Darkmoon Faire
            quests = {
                {
                    key = 'darkmoonFaire',
                    entries = {
                        {
                            quest = 29511, -- Talkin' Tonks
                        },
                    },
                },
            },
        },
    },
}
