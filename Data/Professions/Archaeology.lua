local _, Addon = ...
local L = Addon.L


Addon.data.professionArchaeology = {
    key = 'professions',
    order = 120,
    skillLineId = 794,
    texture = GetSpellTexture(80836),
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
                            quest = 29507, -- Fun for the Little Ones
                            shoppingList = {
                                { 15, 393, 'currency' }, -- Fossil Archaeology Fragment
                            }
                        },
                    },
                },
            },
        },
    },
}
