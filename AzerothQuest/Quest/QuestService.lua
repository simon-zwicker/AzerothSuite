local AQ = _G.AzerothQuest

---@class AzerothQuestObjective
---@field text string
---@field type string?
---@field finished boolean
---@field numFulfilled number?
---@field numRequired number?

---@class AzerothQuestData
---@field questID number
---@field title string
---@field level number?
---@field complete boolean
---@field objectives AzerothQuestObjective[]

---@class AzerothQuestService
local QuestService = {}

---@param questID number
---@return AzerothQuestObjective[]
local function GetObjectives(questID)
    local objectives = {}
    local questObjectives = C_QuestLog.GetQuestObjectives(questID) or {}

    for _, objective in ipairs(questObjectives) do
        table.insert(
            objectives,
            {
                text = objective.text or "",
                type = objective.type,
                finished = objective.finished or false,
                numFulfilled = objective.numFulfilled,
                numRequired = objective.numRequired,
            }
        )
    end

    return objectives
end

---@param questID number
---@return AzerothQuestData
local function BuildQuestData(questID)
    local title = C_QuestLog.GetTitleForQuestID(questID) or ""
    local level = C_QuestLog.GetQuestDifficultyLevel(questID)
    local complete = C_QuestLog.IsComplete(questID) or false
    local objectives = GetObjectives(questID)

    ---@type AzerothQuestData
    local data = {
        questID = questID,
        title = title,
        level = level,
        complete = complete,
        objectives = objectives,
     }

    return data
end

---@return AzerothQuestData[]
function QuestService:GetTrackedQuests()
    local quests = {}
    local count = C_QuestLog.GetNumQuestWatches() or 0

    for index = 1, count do
        local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(index)
        if questID then
            table.insert(quests, BuildQuestData(questID))
        end
    end

    return quests
end

function QuestService:DebugTrackedQuests()
    local quests = self:GetTrackedQuests()
    print("AzerothQuest tracked quests: ", #quests)

    for _, quest in ipairs(quests) do
        print("Quest: ", quest.questID, quest.title, "Level: ", quest.level, "Complete: ", quest.complete)

        for index, objective in ipairs(quest.objectives) do
            print(" Objective: ", index, objective.finished and "DONE" or "OPEN", objective.text, objective.numFulfilled, "/", objective.numRequired)
        end
    end
end

AQ.Quest = QuestService