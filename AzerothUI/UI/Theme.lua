local AUI = _G.AzerothUI

---@type table
local Theme = {}

Theme.Colors = {
    Background = { 0.035, 0.03, 0.025, 0.96, },
    Surface = { 0.4, 0.1, 0.1, 1.0, },
    Border = { 1.0, 0.8, 0.0, 1.0, },
    Gold = { 0.85, 0.67, 0.28, 1.0, },
    Text = { 0.90, 0.86, 0.76, 1.0, },
    TextMuted = { 0.58, 0.55, 0.49, 1.0, },
}

Theme.Spacing = {
    XS = 4,
    SM = 8,
    MD = 12,
    LG = 16,
    XL = 24,
}

Theme.Sizes = {
    Border = 1,
    Header = 36,
    Button = 28,
}

AUI.UI.Theme = Theme