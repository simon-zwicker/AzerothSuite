local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing

---@class AzerothUIText
local Text = {}

---@param parent Frame
---@param font string
---@param color table
---@return FontString
local function CreateText(parent, font, color)
    local text = parent:CreateFontString(nil, "OVERLAY", font)
    Drawing:ApplyTextColor(text, color)
    
    return text
end

---@param parent Frame
---@param value string
---@param anchor Region?
---@param topSpacing number?
---@return Texture
function Text:CreateSectionTitle(parent, value, anchor, topSpacing)
    local title = CreateText(parent, Theme.Font.Title.Template, Theme.Color.Gold)
    title:SetText(value)

    if anchor then
        title:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -(topSpacing or Theme.Spacing.Section))
    else
        title:SetPoint("TOPLEFT", parent, "TOPLEFT")
    end

    local divider = Drawing:CreateDivider(parent, Theme.Color.Border.Highlighted)
    divider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    divider:SetWidth(title:GetStringWidth() + Theme.Spacing.XL)

    return divider
end

---@param parent Frame
---@param value string
---@return FontString
function Text:CreateTitle(parent, value)
    local title = CreateText(parent, Theme.Font.Title.Template, Theme.Color.Gold)
    title:SetText(value)

    return title
end

---@param parent Frame
---@param value string
---@return FontString
function Text:CreateBody(parent, value)
    local body = CreateText(parent, Theme.Font.Body.Template, Theme.Color.Text.Primary)
    body:SetText(value)

    return body
end

---@param parent Frame
---@param value string
---@return FontString
function Text:CreateMuted(parent, value)
    local muted = CreateText(parent, Theme.Font.Muted.Template, Theme.Color.Text.Muted)
    muted:SetText(value)

    return muted
end

---@param parent Frame
---@param value string
---@return FontString
function Text:CreateLabel(parent, value)
    local label = CreateText(parent, Theme.Font.Label.Template, Theme.Color.Text.Label)
    label:SetText(value)

    return label
end

---@param parent Frame
---@param value string
---@return FontString
function Text:CreateSmall(parent, value)
    local small = CreateText(parent, Theme.Font.Small.Template, Theme.Color.Text.Muted)
    small:SetText(value)

    return small
end

AUI.UI.Text = Text