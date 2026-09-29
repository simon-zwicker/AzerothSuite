local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Window = {}

local DEFAULT_WIDTH = 600
local DEFAULT_HEIGHT = 400

local function ApplyColor(texture, color)
    texture:SetColorTexture(
        color[1],
        color[2],
        color[3],
        color[4]
    )
end

local function CreateBackground(frame)
    local background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    ApplyColor(background, Theme.Colors.Background)
end

local function CreateBorder(frame)
    local borderSize = Theme.Sizes.Border
    local color = Theme.Colors.Border
    
    local top = frame:CreateTexture(nil, "BORDER")
    top:SetPoint("TOPLEFT", frame, "TOPLEFT")
    top:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
    top:SetHeight(borderSize)
    ApplyColor(top, color)

    local bottom = frame:CreateTexture(nil, "BORDER")
    bottom:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
    bottom:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    bottom:SetHeight(borderSize)
    ApplyColor(bottom, color)

    local left = frame:CreateTexture(nil, "BORDER")
    left:SetPoint("TOPLEFT", frame, "TOPLEFT")
    left:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
    left:SetHeight(borderSize)
    ApplyColor(left, color)

    local right = frame:CreateTexture(nil, "BORDER")
    right:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
    right:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    right:SetHeight(borderSize)
    ApplyColor(right, color)
end

local function CreateHeader(frame)
    local header = CreateFrame("Frame", nil, frame)
    header:SetPoint("TOPLEFT", frame, "TOPLEFT", Theme.Sizes.Border, -Theme.Sizes.Border)
    header:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -Theme.Sizes.Border, -Theme.Sizes.Border)
    header:SetHeight(Theme.Sizes.Header)
    header:SetFrameLevel(frame:GetFrameLevel() + 1)

    local background = header:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    ApplyColor(background, Theme.Colors.Surface)

    return header
end

local function CreateTitle(header, title)
    local text = header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("LEFT", header, "LEFT", Theme.Spacing.MD, 0)
    text:SetText(title)
    text:SetTextColor(Theme.Colors.Text[1], Theme.Colors.Text[2], Theme.Colors.Text[3], Theme.Colors.Text[4])

    return text
end

local function CreateCloseButton(header, frame)
    local button = CreateFrame("Button", nil, header)
    button:SetSize(Theme.Sizes.Button, Theme.Sizes.Button)
    button:SetPoint("RIGHT", header, "RIGHT", -Theme.Spacing.XS, 0)

    local text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("CENTER")
    text:SetText("x")
    text:SetTextColor(Theme.Colors.TextMuted[1], Theme.Colors.TextMuted[2], Theme.Colors.TextMuted[3],
        Theme.Colors.TextMuted[4])

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
        options.width or DEFAULT_WIDTH,
        options.height or DEFAULT_HEIGHT
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