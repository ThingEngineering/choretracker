local _, Addon = ...
local L = Addon.L


local CMF_GetCurrentRenownLevel = C_MajorFactions.GetCurrentRenownLevel

Addon.data.chores.choresPrey = {
    key = 'prey',
    name = L['section:prey'],
    order = 50,
    minimumLevel = 80,
    categories = {
        {
            key = 'midnightPrey',
            drops = {
                {
                    key = 'normal',
                    minimumLevel = 80,
                    pick = 2,
                    groupSameItem = true,
                    requiredAccountQuest = 93086, -- To the Sanctum!
                    entries = {
                        { quest = 93168, item = 257023 },
                        { quest = 93853, item = 257023 },
                    },
                },
                {
                    key = 'hard',
                    minimumLevel = 90,
                    pick = 2,
                    groupSameItem = true,
                    requiredQuest = 92178, -- Practical Magic
                    entries = {
                        { quest = 93169, item = 257026 },
                        { quest = 93857, item = 257026 },
                    },
                },
                {
                    key = 'nightmare',
                    minimumLevel = 90,
                    pick = 2,
                    groupSameItem = true,
                    requiredQuest = 92182, -- The Sheep or the Wolf
                    entries = {
                        { quest = 93170, item = 262346 },
                        { quest = 93861, item = 262346 },
                    },
                },
                {
                    key = 'reputation',
                    minimumLevel = 80,
                    groupSameItem = true,
                    entries = {
                        { quest = 95000, currency = 3387 },
                        { quest = 95001, currency = 3387 },
                        { quest = 95002, currency = 3387 },
                        { quest = 95003, currency = 3387 },
                    },
                },
            },
            quests = {
                {
                    key = 'nightmarishTask',
                    minimumLevel = 90,
                    requiredQuest = 92182, -- The Sheep or the Wolf
                    entries = {
                        { quest = 94446 },
                    },
                },
            },
        }
    },
}
