local AUI = _G.AzerothUI

local DEFAULT_LOCALE = "enUS"

---@class AzerothUILocalization
---@field Register fun(self: AzerothUILocalization, namespace: string, locale: string, strings: table<string, string>)
---@field Get fun(self: AzerothUILocalization, namespace: string): table<string, string>
local Localization = {}

---@type table<string, table<string, table<string, string>>>
local registries = {}

local function GetClientLocale()
    return GetLocale()
end

local function GetRegistry(namespace)
    if not registries[namespace] then
        registries[namespace] = {}
    end
    return registries[namespace]
end

function Localization:Register(namespace, locale, strings)
    if type(namespace) ~= "string" or type(locale) ~= "string" or type(strings) ~= "table" then
        return
    end

    local registry = GetRegistry(namespace)
    registry[locale] = registry[locale] or {}

    for key, value in pairs(strings) do
        registry[locale][key] = value
    end
end

function Localization:Get(namespace)
    local registry = GetRegistry(namespace)
    local locale = GetClientLocale()
    local active = registry[locale] or {}
    local fallback = registry[DEFAULT_LOCALE] or {}

    return setmetatable({}, {
        __index = function(_, key)
            if active[key] ~= nil then
                return active[key]
            end

            if fallback[key] ~= nil then
                return fallback[key]
            end

            return "<" .. key .. ">"
        end,
    })
end

AUI.Localization = Localization