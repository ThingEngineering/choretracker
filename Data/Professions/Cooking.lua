local _, Addon = ...
local L = Addon.L


Addon.data.professionCooking = {
    order = 121,
    skillLineId = 185,
    texture = GetSpellTexture(2550),
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
