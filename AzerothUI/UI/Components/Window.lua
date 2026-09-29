local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing
local Window = {}

local function CreateBackground(frame)
    local background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    Drawing:ApplyColor(background, Theme.Colors.Background)
end

local function CreateBorder(frame)
    Drawing:CreateBorder(frame, 0, Theme.Sizes.Border.Outer, Theme.Colors.BorderOuter)
    Drawing:CreateBorder(frame, Theme.Sizes.Border.Inset, Theme.Sizes.Border.Inner, Theme.Colors.BorderInner)
end

local function CreateHeader(frame)
    local inset = Theme.Sizes.Border.Inset + 1

    local header = CreateFrame("Frame", nil, frame)
    header:SetPoint("TOPLEFT", frame, "TOPLEFT", inset, -inset)
    header:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -inset, -inset)
    header:SetHeight(Theme.Sizes.Header.Height)
    header:SetFrameLevel(frame:GetFrameLevel() + 1)

    local divider = header:CreateTexture(nil, "ARTWORK")
    divider:SetPoint("BOTTOMLEFT", header, "BOTTOMLEFT")
    divider:SetPoint("BOTTOMRIGHT", header, "BOTTOMRIGHT")
    divider:SetHeight(Theme.Sizes.Header.Divider)
    Drawing:ApplyColor(divider, Theme.Colors.BorderHighlight)

    local background = header:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    Drawing:ApplyColor(background, Theme.Colors.Surface)

    return header
end

local function CreateTitle(header, title)
    local text = header:CreateFontString(nil, "OVERLAY", Theme.Fonts.Title.Template)
    text:SetPoint("LEFT", header, "LEFT", Theme.Spacing.LG, 0)
    text:SetText(title)
    Drawing:ApplyTextColor(text, Theme.Colors.Gold)

    return text
end

local function CreateCloseButton(header, frame)
    local button = CreateFrame("Button", nil, header)
    button:SetSize(Theme.Sizes.Button.Normal, Theme.Sizes.Button.Normal)
    button:SetPoint("RIGHT", header, "RIGHT", -Theme.Spacing.XS, 0)

    local text = button:CreateFontString(nil, "OVERLAY", Theme.Fonts.Body.Template)
    text:SetPoint("CENTER")
    text:SetText("x")
    Drawing:ApplyTextColor(text, Theme.Colors.TextMuted)

    button:SetScript(
        "OnClick",
        function()
            frame:Hide()
        end
    )

    return button
end

---@class AzerothUIWindowOptions
---@field name string?
---@field title string?
---@field width number?
---@field height number?

---@param options AzerothUIWindowOptions?
---@return Frame
function Window:Create(options)
    options = options or {}
    
    local frame = CreateFrame("Frame", options.name, UIParent)
    frame:SetSize(
        options.width or Theme.Sizes.Window.Width,
        options.height or Theme.Sizes.Window.Height
    )
    frame:SetPoint("CENTER")
    frame:SetFrameLevel(100)
    
    CreateBackground(frame)
    CreateBorder(frame)

    local header = CreateHeader(frame)
    CreateTitle(header, options.title or "")
    CreateCloseButton(header, frame)

    return frame
end

AUI.UI.Window = Window