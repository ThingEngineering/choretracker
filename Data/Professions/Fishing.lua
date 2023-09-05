local _, Addon = ...
local L = Addon.L


Addon.data.professionFishing = {
    key = 'professions',
    order = 122,
    skillLineId = 356,
    texture = GetSpellTexture(271616),
    categories = {
        {
            key = 'event',
            name = L['category:event'],
            quests = {
                {
                    key = 'darkmoonFaire',
                    requiredEventIds = { 479 }, -- Darkmoon Faire
                    entries = {
                        {
                            quest = 29513, -- Spoilin' for Salty Sea Dogs
                        },
                    },
                },
            },
        },
    },
}
