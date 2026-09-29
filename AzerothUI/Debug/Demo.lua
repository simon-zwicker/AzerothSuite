local AUI = _G.AzerothUI
local SlashCmdList = _G["SlashCmdList"]

local demoWindow

local function ShowDemo()
    if not demoWindow then
        demoWindow = AUI.UI.Window:Create(
            {
                name = "AzerothUIDemoWindow",
                title = "AzerothUI Demo",
                width = 600,
                height = 400,
            }
        )
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