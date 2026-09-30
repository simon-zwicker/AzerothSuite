local AUI = _G.AzerothUI

local Drawing = {}

---@param frame Frame
---@param point1 string
---@param point2 string
---@param offsetX1 number
---@param offsetY1 number
---@param offsetX2 number
---@param offsetY2 number
---@param size number
---@param color table
---@param vertical boolean
---@return Texture
local function CreateBorderLine(frame, point1, point2, offsetX1, offsetY1, offsetX2, offsetY2, size, color, vertical)
    local texture = frame:CreateTexture(nil, "BORDER")
    texture:SetPoint(point1, frame, point1, offsetX1, offsetY1)
    texture:SetPoint(point2, frame, point2, offsetX2, offsetY2)

    if vertical then
        texture:SetWidth(size)
    else
        texture:SetHeight(size)
    end

    Drawing:ApplyColor(texture, color)

    return texture
end

---@class AzerothUIBorder
---@field Top Texture
---@field Bottom Texture
---@field Left Texture
---@field Right Texture

---@param frame Frame
---@param inset number
---@param size number
---@param color table
---@return AzerothUIBorder
function Drawing:CreateBorder(frame, inset, size, color)
    local border = {}
    border.Top = CreateBorderLine(frame, "TOPLEFT", "TOPRIGHT", inset, -inset, -inset, -inset, size, color, false)
    border.Bottom = CreateBorderLine(frame, "BOTTOMLEFT", "BOTTOMRIGHT", inset, inset, -inset, inset, size, color, false)
    border.Left = CreateBorderLine(frame, "TOPLEFT", "BOTTOMLEFT", inset, -inset, inset, inset, size, color, true)
    border.Right = CreateBorderLine(frame, "TOPRIGHT", "BOTTOMRIGHT", -inset, -inset, -inset, inset, size, color, true)
    return border
end

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

---@param border AzerothUIBorder
---@param color table
function Drawing:ApplyBorderColor(border, color)
    Drawing:ApplyColor(border.Top, color)
    Drawing:ApplyColor(border.Bottom, color)
    Drawing:ApplyColor(border.Left, color)
    Drawing:ApplyColor(border.Right, color)
end

---@param frame AzerothUIButtonFrame
---@param color table
function Drawing:ApplyButtonBackground(frame, color)
    frame.Background:SetColorTexture(color[1], color[2], color[3], color[4])
end

---@param parent Frame
---@param color table
---@param height number?
---@return Texture
function Drawing:CreateDivider(parent, color, height)
    local divider = parent:CreateTexture(nil, "OVERLAY")
    divider:SetHeight(height or 1)
    Drawing:ApplyColor(divider, color)

    return divider
end

AUI.UI.Drawing = Drawing