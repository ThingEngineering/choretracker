local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionFishing = {
    key = 'professions',
    order = 122,
    skillLineId = 356,
    texture = C_Spell.GetSpellTexture(271616),
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
