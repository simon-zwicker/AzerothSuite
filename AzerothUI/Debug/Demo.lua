local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing
local Text = AUI.UI.Text
local Button = AUI.UI.Button
local IconButton = AUI.UI.IconButton
local Window = AUI.UI.Window
local SlashCmdList = _G["SlashCmdList"]

local demoWindow

---@param content Frame
---@return FontString
local function BuildDemoTextContent(content)
    local typographyTitle = Text:CreateSectionTitle(content, "Typography")

    local titleExample = Text:CreateTitle(content, "AzerothUI Title")
    titleExample:SetPoint("TOPLEFT", typographyTitle, "BOTTOMLEFT", 0, -Theme.Spacing.XL)

    local bodyExample = Text:CreateBody(content, "Normal body text")
    bodyExample:SetPoint("TOPLEFT", titleExample, "BOTTOMLEFT", 0, -Theme.Spacing.SM)

    local mutedExample = Text:CreateMuted(content, "Muted secondary text")
    mutedExample:SetPoint("TOPLEFT", bodyExample, "BOTTOMLEFT", 0, -Theme.Spacing.SM)

    local labelExample = Text:CreateLabel(content, "Label text")
    labelExample:SetPoint("TOPLEFT", mutedExample, "BOTTOMLEFT", 0, -Theme.Spacing.MD)

    local smallExample = Text:CreateSmall(content, "Small secondary information")
    smallExample:SetPoint("TOPLEFT", labelExample, "BOTTOMLEFT", 0, -Theme.Spacing.SM)

    return smallExample
end

---@param content Frame
---@param anchor Region
local function BuildDemoButtonContent(content, anchor)
    local buttonTitle = Text:CreateSectionTitle(content, "Buttons", anchor)
    
    local button = Button:Create(content, "Normal Button")
    button:SetPoint("TOPLEFT", buttonTitle, "BOTTOMLEFT", 0, -Theme.Spacing.XL)

    local disableButton = Button:Create(content, "Disabled Butto")
    disableButton:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -Theme.Spacing.MD)
    disableButton:DisableButton()
    
    button:SetScript(
        "OnClick",
        function ()
            print("AzerothUI Button clicked")
        end
    )
end

---@param content Frame
local function BuildDemoContent(content)
    local textAnchor = BuildDemoTextContent(content)
    BuildDemoButtonContent(content, textAnchor)
end

local function ShowDemo()
    if not demoWindow then
        demoWindow = Window:Create(
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