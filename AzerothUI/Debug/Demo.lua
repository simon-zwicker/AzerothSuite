local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing
local Text = AUI.UI.Text
local SlashCmdList = _G["SlashCmdList"]

local demoWindow

---@param parent Frame
---@param title string
---@return FontString
local function CreateSectionTitle(parent, title)
    local text = parent:CreateFontString(nil, "OVERLAY", Theme.Fonts.Title.Template)
    text:SetText(title)
    Drawing:ApplyTextColor(text, Theme.Colors.Gold)

    return text
end

---@param parent Frame
---@param textValue string
---@param muted boolean?
---@return FontString
local function CreateText(parent, textValue, muted)
    local text = parent:CreateFontString(nil, "OVERLAY", Theme.Fonts.Body.Template)
    text:SetText(textValue)
    Drawing:ApplyTextColor(text, muted and Theme.Colors.TextMuted or Theme.Colors.Text)

    return text
end

---@param content Frame
local function BuildDemoContent(content)
    local typographyTitle = Text:CreateTitle(content, "Typography")
    typographyTitle:SetPoint("TOPLEFT", content, "TOPLEFT")

    local titleExample = CreateSectionTitle(content, "AzerothUI Title")
    titleExample:SetPoint("TOPLEFT", typographyTitle, "BOTTOMLEFT", 0, -Theme.Spacing.LG)

    local bodyExample = CreateText(content, "Normal body text")
    bodyExample:SetPoint("TOPLEFT", titleExample, "BOTTOMLEFT", 0, -Theme.Spacing.SM)

    local mutedExample = CreateText(content, "Muted secondary text", true)
    mutedExample:SetPoint("TOPLEFT", bodyExample, "BOTTOMLEFT", 0, -Theme.Spacing.SM)
end

local function ShowDemo()
    if not demoWindow then
        demoWindow = AUI.UI.Window:Create(
            {
                name = "AzerothUIDemoWindow",
                title = "AzerothUI Demo",
                width = 1200,
                height = 800,
            }
        )

        BuildDemoContent(demoWindow.Content)
    end

    demoWindow:Show()
end

---@param message string
local function HandleSlashCommand(message)
    message = string.lower(message or "")

    if message == "demo" then
        ShowDemo()
    end
end

_G["SLASH_AZEROTHUI1"] = "/aui"
SlashCmdList.AZEROTHUI = HandleSlashCommand