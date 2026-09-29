local ADDON_NAME = ...

---@class AzerothUI
---@field Name string
---@field Version string
---@field UI table
---@field Localization AzerothUILocalization
---@field GetVersion fun(self: AzerothUI): string

---@diagnostic disable-next-line: global-element
AzerothUI = AzerothUI or {}

---@type AzerothUI
local AUI = AzerothUI

AUI.Name = ADDON_NAME
AUI.Version = "0.1.0"

AUI.UI = AUI.UI or {}

function AUI:GetVersion()
    return self.Version
end