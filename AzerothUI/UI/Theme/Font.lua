local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme

print("Loaded Font.lua")

Theme.Font = {
    Title = {
        Template = "GameFontNormalLarge",
    },

    Body = {
        Template = "GameFontNormal",
    },

    Muted = {
        Template = "GameFontDisable",
    },

    Label = {
        Template = "GameFontNormal",
    },

    Small = {
        Template = "GameFontNormalSmall",
    },
}