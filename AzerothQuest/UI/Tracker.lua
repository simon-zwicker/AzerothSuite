---@type AzerothQuest
local AQ = _G.AzerothQuest
---@type AzerothUI
local AUI = _G.AzerothUI

local Theme = AUI.UI.Theme
local Text = AUI.UI.Text
local Window = AUI.UI.Window
local L11n = AUI.Localization:Get("AzerothQuest")

---@class AzerothQuestTracker
local Tracker = {}

local trackerWindow

local function BuildContent(content)
    local title = Text:CreateSectionTitle(content, L11n.TRACKER_SECTION_TRACKED)
    local emptyText = Text:CreateMuted(content, L11n.TRACKER_EMPTY)

    emptyText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -Theme.Spacing.LG)
end

function Tracker:Create()
    if trackerWindow then
        return trackerWindow
    end

    trackerWindow = Window:Create(
        {
            name = "AzerothQuestTracker",
            title = L11n.TRACKER_TITLE,
            width = 420,
            height = 800,
        }
    )

    BuildContent(trackerWindow.Content)

    return trackerWindow
end

function Tracker:Show()
    local frame = self:Create()
    frame:Show()
end

function Tracker:Hide()
    if not trackerWindow then
        return
    end
    trackerWindow:Hide()
end

function Tracker:Toggle()
    local frame = self:Create()

    if frame:IsShown() then
        frame:Hide()
        return
    end

    frame:Show()
end

AQ.UI.Tracker = Tracker