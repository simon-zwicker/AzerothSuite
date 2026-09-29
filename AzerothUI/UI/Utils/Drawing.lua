local AUI = _G.AzerothUI

local Drawing = {}

---@param texture Texture
---@param color table
function Drawing:ApplyColor(texture, color)
    texture:SetColorTexture(color[1], color[2], color[3], color[4])
end

---@param fontString FontString
---@param color table
function Drawing:ApplyTextColor(fontString, color)
    fontString:SetTextColor(color[1], color[2], color[3], color[4])
end

AUI.UI.Drawing = Drawing