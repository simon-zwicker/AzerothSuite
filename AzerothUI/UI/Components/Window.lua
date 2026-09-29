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

    local divider = Drawing:CreateDivider(frame, Theme.Colors.Gold)
    divider:SetPoint("BOTTOMLEFT", header, "BOTTOMLEFT")
    divider:SetPoint("BOTTOMRIGHT", header, "BOTTOMRIGHT")
    Drawing:ApplyColor(divider, Theme.Colors.BorderHighlight)

    local background = header:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    Drawing:ApplyColor(background, Theme.Colors.HeaderTop)

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
    local button = AUI.UI.IconButton:Create(
        {
            parent = header,
            text = "X",
            onClick = function()
                frame:Hide()
            end   
        }
    )
    button:SetPoint("RIGHT", header, "RIGHT", -Theme.Spacing.SM, 0)

    return button
end

---@param frame Frame
---@param header Frame
---@return Frame
local function CreateContent(frame, header)
    local content = CreateFrame("Frame", nil, frame)

    content:SetPoint("TOPLEFT", header, "BOTTOMLEFT", Theme.Spacing.LG, -Theme.Spacing.LG)
    content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -Theme.Spacing.LG, Theme.Spacing.LG)

    return content
end

---@class AzerothUIWindowOptions
---@field name string?
---@field title string?
---@field width number?
---@field height number?

---@class AzerothUIWindow : Frame
---@field Content Frame

---@param options AzerothUIWindowOptions?
---@return AzerothUIWindow
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

    local content = CreateContent(frame, header)
    frame.Content = content

    return frame
end

AUI.UI.Window = Window