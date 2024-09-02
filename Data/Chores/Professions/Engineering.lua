local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionEngineering = {
    key = 'professions',
    order = 103,
    skillLineId = 202,
    texture = C_Spell.GetSpellTexture(4036),
    categories = {
        {
            key = 'warWithin',
            name = EXPANSION_NAME10,
            skillLineId = 2875,
            drops = {
                {
                    key = 'mob/treasure',
                    entries = {
                        { quest=83261, item=225229 }, -- Earthen Induction Coil
                        { quest=83260, item=225228 }, -- Rust-Locked Mechanism
                    },
                },
            },
            quests = {
                {
                    key = 'treatise',
                    entries = {
                        { quest=83728, item=222621 }, -- Algari Treatise on Engineering
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=84128 }, -- Engineering Services Requested
                    },
                },
            },
        },
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2827,
            drops = {
                {
                    key = 'mob',
                    defaultEnabled = false,
                    entries = {
                        { quest=70516, item=198969, desc='Keeper' }, -- Keeper's Mark
                        { quest=70517, item=198970, desc='Dragonkin' }, -- Infinitely Attachable Pair o' Docks
                    },
                },
                {
                    key = 'treasure',
                    defaultEnabled = false,
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
                    key = 'provide',
                    skill = 45,
                    defaultEnabled = false,
                    entries = {
                        { quest=70539 }, -- And You Thought They Did Nothing
                        { quest=70540 }, -- An Engineer's Best Friend
                        { quest=70545 }, -- Blingtron 8000...?
                        { quest=70557 }, -- No Scopes
                    },
                },
                {
                    key = 'task',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=66890 }, -- Stolen Tools
                        { quest=66891 }, -- Explosive Ash
                        { quest=66942 }, -- Enemy Engineering
                        { quest=72396 }, -- Horns of Plenty
                        { quest=75575, level=70 }, -- Ballistae Bits [ZC]
                        { quest=75608, level=70 }, -- Titan Trash or Titan Treasure [ZC]
                        { quest=77891, level=70 }, -- An Unlikely Engineer [ED]
                        { quest=77938, level=70 }, -- Fixing the Dream [ED]
                    },
                },
                {
                    key = 'treatise',
                    defaultEnabled = false,
                    entries = {
                        { quest=74111, item=198510 }, -- Draconic Treatise on Engineering
                    },
                },
                {
                    key = 'orders',
                    skill = 25,
                    defaultEnabled = false,
                    entries = {
                        { quest=70591 }, -- Engineering Services Requested
                    },
                },
            },
        },
        {
            key = 'event',
            name = L['category:event'],
            quests = {
                {
                    key = 'darkmoonFaire',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
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
