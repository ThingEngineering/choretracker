local _, Addon = ...
local L = Addon.L


Addon.data.chores.professionArchaeology = {
    key = 'professions',
    order = 120,
    skillLineId = 794,
    texture = C_Spell.GetSpellTexture(80836),
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
