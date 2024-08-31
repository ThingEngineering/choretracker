local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionCooking = {
    key = 'professions',
    order = 121,
    skillLineId = 185,
    texture = C_Spell.GetSpellTexture(2550),
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
                            quest = 29509, -- Putting the Crunch in the Frog
                            shoppingList = {
                                { 5, 30817 }, -- Simple Flour
                            }
                        },
                    },
                },
            },
        },
    },
}
