local AQ = _G.AzerothQuest
local SlashCmdList = _G["SlashCmdList"]

local function HandleSlashCommand(message)
    message = string.lower(message or "")

    if message == "" or message == "toggle" then
        AQ.UI.Tracker:Toggle()
        return 
    end

    if message == "show" then
        AQ.UI.Tracker:Show()
        return
    end

    if message == "hide" then
        AQ.UI.Tracker:Hide()
        return
    end

    if message == "debug" then
        AQ.Quest:DebugTrackedQuests()
        return
    end

    print("AzerothQuest commands:")
    print("/aq")
    print("/aq show")
    print("/aq hide")
    print("/aq debug")
end

_G["SLASH_AZEROTHQUEST1"] = "/aq"
SlashCmdList.AZEROTHQUEST = HandleSlashCommand