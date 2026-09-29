local AUI = _G.AzerothUI

local Theme = {}

Theme.Colors = {
    Background = { 0.025, 0.022, 0.018, 0.97, },
    Surface = { 0.055, 0.047, 0.038, 1.0, },
    SurfaceRaised = { 0.085, 0.070, 0.052, 1.0, },
    Border = { 0.24, 0.19, 0.11, 1.0, },
    BorderHighlight = { 0.48, 0.36, 0.17, 1.0 },
    BorderOuter = { 0.08, 0.065, 0.045, 1.0 },
    BorderInner = { 0.38, 0.28, 0.12, 1.0 },
    Gold = { 0.82, 0.62, 0.25, 1.0, },
    GoldMuted = { 0.55, 0.42, 0.20, 1.0, },
    Text = { 0.91, 0.87, 0.78, 1.0, },
    TextMuted = { 0.57, 0.54, 0.48, 1.0 },
    HeaderHighlight = { 0.16, 0.12, 0.07, 1.0 },
}

Theme.Spacing = {
    XS = 4,
    SM = 8,
    MD = 12,
    LG = 16,
    XL = 24,
}

Theme.Sizes = {
    Border = {
        Outer = 2,
        Inner = 1,
        Inset = 3,
    },

    Window = {
        Width = 600,
        Height = 400,
    },

    Header = {
        Height = 40,
        Divider = 1,
    },

    Button = {
        Small = 24,
        Normal = 28,
    },
}

Theme.Fonts = {
    Title = {
        Template = "GameFontNormalLarge"
    },
    
    Body = {
        Template = "GameFontHighlight"
    },
    
    Muted = {
        Template = "GameFontDisable"
    },
}

AUI.UI.Theme = Theme