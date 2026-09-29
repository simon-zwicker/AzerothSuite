local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing

---@class AzerothUIText
local Text = {}

---@param parent Frame
---@param fontObject string
---@param color table
---@return FontString
local function CreateText(parent, fontObject, color)
    local text = parent:CreateFontString(nil, "OVERLAY", fontObject)
    Drawing:ApplyTextColor(text, color)
    
    return text
end

---@param parent Frame
---@param value string
---@return FontString
function Text:CreateTitle(parent, value)
    local title = CreateText(parent, Theme.Fonts.Title.Template, Theme.Colors.Gold)
    title:SetText(value)

    local divider = Drawing:CreateDivider(parent, Theme.Colors.Gold)
    divider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    divider:SetWidth(title:GetStringWidth() + Theme.Spacing.XL)
    Drawing:ApplyColor(divider, Theme.Colors.BorderHighlight)

    return title
end

AUI.UI.Text = Text