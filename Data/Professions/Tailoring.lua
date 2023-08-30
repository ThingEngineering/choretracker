local _, Addon = ...


Addon.data.professionTailoring = {
    skillLineId = 197,
    texture = GetSpellTexture(3908),
    categories = {
        {
            key = 'dragonflight',
            name = EXPANSION_NAME9,
            skillLineId = 2831,
            drops = {
                {
                    key = 'mob',
                    entries = {
                        { quest=70524, item=198977, desc='Centaur' }, -- Ohn'arhan Weave
                        { quest=70525, item=198978, desc='Gnoll' }, -- Stupidly Effective Stitchery
                    },
                },
                {
                    key = 'treasure',
                    entries = {
                        { quest=66386, item=193898 }, -- Umbral Bone Needle
                        { quest=66387, item=193899 }, -- Primalweave Spindle
                    },
                },
                {
                    key = 'forbiddenReach',
                    defaultEnabled = false,
                    entries = {
                        { quest=74931, item=204225, level=70, desc='Gareed' }, -- Perfect Windfeather
                    },
                },
            },
            quests = {
                {
                    key = 'craft',
                    entries = {
                        { quest=70572 }, -- The Cold Does Bother Them, Actually
                        { quest=70582 }, -- Weave Well Enough Alone
                        { quest=70586 }, -- Sew Many Cooks
                        { quest=70587 }, -- A Knapsack Problem
                    },
                },
                {
                    key = 'gather',
                    entries = {
                        { quest=66899 }, -- Fuzzy Legs
                        { quest=66952 }, -- The Gnoll's Clothes
                        { quest=66953 }, -- All Things Fluffy
                        { quest=72410 }, -- Pincers and Needles
                        { quest=75407, level=70 }, -- Silk Scavenging [ZC]
                        { quest=75600, level=70 }, -- Silk's Silk [ZC]
                    },
                },
                {
                    key = 'orders',
                    entries = {
                        { quest=70595 }, -- Tailoring Services Requested
                    },
                },
                {
                    key = 'treatise',
                    entries = {
                        { quest=74115, item=194698 }, -- Draconic Treatise on Tailoring
                    },
                },
            },
        },
    },
}
