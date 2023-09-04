local _, Addon = ...
local L = Addon.L


Addon.data.professionFishing = {
    order = 122,
    skillLineId = 356,
    texture = GetSpellTexture(271616),
    categories = {
        {
            key = 'event',
            name = L['category:event'],
            requiredEventId = 479, -- Darkmoon Faire
            quests = {
                {
                    key = 'darkmoonFaire',
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
