local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing
local IconButton = AUI.UI.IconButton
local Window = {}

local function CreateBackground(frame)
    local background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    Drawing:ApplyColor(background, Theme.Color.Background.Primary)
end

local function CreateBorder(frame)
    Drawing:CreateBorder(frame, 0, Theme.Size.Border.Outer, Theme.Color.Border.Outer)
    Drawing:CreateBorder(frame, Theme.Size.Border.Inset, Theme.Size.Border.Inner, Theme.Color.Border.Inner)
end

local function CreateHeader(frame)
    local inset = Theme.Size.Border.Inset + 1

    local header = CreateFrame("Frame", nil, frame)
    header:SetPoint("TOPLEFT", frame, "TOPLEFT", inset, -inset)
    header:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -inset, -inset)
    header:SetHeight(Theme.Size.Header.Height)
    header:SetFrameLevel(frame:GetFrameLevel() + 1)

    local divider = Drawing:CreateDivider(frame, Theme.Color.Border.Highlighted)
    divider:SetPoint("BOTTOMLEFT", header, "BOTTOMLEFT")
    divider:SetPoint("BOTTOMRIGHT", header, "BOTTOMRIGHT")

    local background = header:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    Drawing:ApplyColor(background, Theme.Color.Header.Normal)

    return header
end

local function CreateTitle(header, title)
    local text = header:CreateFontString(nil, "OVERLAY", Theme.Font.Title.Template)
    text:SetPoint("LEFT", header, "LEFT", Theme.Spacing.LG, 0)
    text:SetText(title)
    Drawing:ApplyTextColor(text, Theme.Color.Gold)

    return text
end

local function CreateCloseButton(header, frame)
    local button = IconButton:Create(
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

    ---@type AzerothUIWindow
    local frame = CreateFrame("Frame", options.name, UIParent)
    frame:SetSize(
        options.width or Theme.Size.Window.Width,
        options.height or Theme.Size.Window.Height
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