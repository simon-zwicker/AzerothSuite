local AQ = _G.AzerothQuest
local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing
local Text = AUI.UI.Text
local L11n = AUI.Localization:Get("AzerothQuest")

---@class AzerothQuestRowFrame : Frame
---@field Quest AzerothQuestData
---@field Title FontString
---@field Objectives FontString[]

---@class AzerothQuestRow
local QuestRow = {}

---@param parent Frame
---@param quest AzerothQuestData
---@return AzerothQuestRowFrame
function QuestRow:Create(parent, quest)
    ---@type AzerothQuestRowFrame
    local frame = CreateFrame("Frame", nil, parent)
    frame.Quest = quest
    frame.Objectives = {}

    local titleRaw = string.format("[%d] %s", quest.level, quest.title)
    local title = Text:CreateBody(frame, titleRaw)
    title:SetPoint("TOPLEFT", frame, "TOPLEFT")
    Drawing:ApplyTextColor(title, Theme.Color.Quest.Title)
    frame.Title = title

    local lastAnchor = title
    local first

    for _, objective in ipairs(quest.objectives) do
        local text = Text:CreateSmall(frame, objective.text)
        Drawing:ApplyTextColor(text, objective.finished and Theme.Color.Quest.Completed or Theme.Color.Quest.Requirement)

        if not first then
            text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", Theme.Spacing.SM, -Theme.Spacing.XS)
            first = text
        else
            text:SetPoint("TOPLEFT", lastAnchor, "BOTTOMLEFT", 0, -Theme.Spacing.XS)
        end

        if objective.finished then
            local completed = Text:CreateSmall(frame, "✓ " .. L11n.OBJECTIVE_COMPLETED)
            Drawing:ApplyTextColor(completed, Theme.Color.Quest.Success)
            completed:SetPoint("LEFT", text, "RIGHT", Theme.Spacing.SM, 0)
        end

        table.insert(frame.Objectives, text)
        lastAnchor = text
    end

    local height = title:GetHeight()

    for _, objective in ipairs(frame.Objectives) do
        height = height + Theme.Spacing.XS + objective:GetHeight()
    end

    frame:SetHeight(height)
    frame:SetPoint("RIGHT", parent, "RIGHT")

    return frame
end

AQ.UI.QuestRow = QuestRow