local ADDON_NAME = ...

---@class AzerothUI
---@field Name string
---@field Version string
---@field UI table
---@field Localization AzerothUILocalization
---@field GetVersion fun(self: AzerothUI): string

---@type AzerothUI
local AUI = _G.AzerothUI or {}
_G.AzerothUI = AUI

AUI.Name = ADDON_NAME
AUI.Version = "0.1.0"

AUI.UI = AUI.UI or {}

function AUI:GetVersion()
    return self.Version
end