local Addon = LibStub('AceAddon-3.0'):GetAddon('ChoreTracker')


Addon.data.professions.alchemy = {
    skillLineId = 171,
    quests = {
        craft = {
            { id=70530 }, -- Examination Week
            { id=70531 }, -- Mana Markets
            { id=70532 }, -- Aiding the Raiding
            { id=70533 }, -- Draught, Oiled Again
        },
        dropForbiddenReach = {
            { id=74935, level=70, desc="Drops from Agni Blazehoof" }, -- Blazehoof Ashes
        },
        dropMob = {
            { id=70504, item=198963, desc="Drops from Decayed mobs" }, -- Decaying Phlegm
            { id=70511, item=198964, desc="Drops from Elemental mobs" }, -- Elementious Splinter
        },
        dropTreasure = {
            { id=66373, item=193891 }, -- Experimental Substance
            { id=66374, item=193897 }, -- Reawakened Catalyst
        },
        gather = {
            { id=66937 }, -- Decaying News
            { id=66938 }, -- Mammoth Marrow
            { id=66940 }, -- Elixir Experiment
            { id=72427 }, -- Animated Infusion
            { id=75363, level=70 }, -- Deepflayer Dust [ZC]
            { id=75371, level=70 }, -- Fascinating Fungi [ZC]
        },
        treatise = {
            { 74108 }, -- 
        },
    },
}
