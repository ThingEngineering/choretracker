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
            key = 'midnight',
            drops = {
                {
                    key = 'reputation',
                    minimumLevel = 80,
                    groupSameItem = true,
                    filter = function()
                        -- the weekly cap only applies when you're below renown 4
                        return CMF_GetCurrentRenownLevel(2764) < 4
                    end,
                    entries = {
                        { quest = 95000, currency = 3387 },
                        { quest = 95001, currency = 3387 },
                        { quest = 95002, currency = 3387 },
                        { quest = 95003, currency = 3387 },
                    },
                },
            }
        }
    },
}
