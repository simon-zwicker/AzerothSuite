local AUI = _G.AzerothUI

local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing

local IconButton = {}

---@class AzerothUIIconButtonOptions
---@field parent Frame
---@field text string?
---@field size number?
---@field onClick fun()?

---@param options AzerothUIIconButtonOptions
---@return Button
function IconButton:Create(options)
    local size = options.size or Theme.Size.Button.Square.Normal
    
    local button = CreateFrame("Button", nil, options.parent)
    button:SetSize(size, size)

    local background = button:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(button)
    Drawing:ApplyColor(background, Theme.Color.Surface.Raised)
    background:SetAlpha(0)

    local text = button:CreateFontString(nil, "OVERLAY", Theme.Font.Body.Template)
    text:SetPoint("CENTER", 0, 1)
    text:SetText(options.text or "")
    Drawing:ApplyTextColor(text, Theme.Color.Text.Muted)

    button:SetScript(
        "OnEnter",
        function()
            background:SetAlpha(1)
            Drawing:ApplyTextColor(text, Theme.Color.Gold)
        end
    )

    button:SetScript(
        "OnLeave",
        function ()
            background:SetAlpha(0)
            Drawing:ApplyTextColor(text, Theme.Color.Text.Muted)
        end
    )

    if options.onClick then
        button:SetScript("OnClick", options.onClick)
    end

    return button
end

AUI.UI.IconButton = IconButton
