local AUI = _G.AzerothUI
local Theme = AUI.UI.Theme
local Drawing = AUI.UI.Drawing
local Text = AUI.UI.Text

---@class AzerothUIButtonFrame: Button
---@field Background Texture
---@field Border AzerothUIBorder
---@field Label FontString
---@field isEnabled fun(self: AzerothUIButtonFrame): boolean
---@field EnableButton fun(self: AzerothUIButtonFrame)
---@field DisableButton fun(self: AzerothUIButtonFrame)

---@class AzerothUIButton
local Button = {}

---@param frame AzerothUIButtonFrame
local function ApplyNormalState(frame)
    Drawing:ApplyButtonBackground(frame, Theme.Color.Button.Normal)
    Drawing:ApplyBorderColor(frame.Border, Theme.Color.Border.Inner)
    Drawing:ApplyTextColor(frame.Label, Theme.Color.Text.Primary)
end

---@param frame AzerothUIButtonFrame
local function ApplyHighlightedState(frame)
    Drawing:ApplyButtonBackground(frame, Theme.Color.Button.Highlighted)
    Drawing:ApplyBorderColor(frame.Border, Theme.Color.Border.Highlighted)
end

---@param frame AzerothUIButtonFrame
local function ApplyDisabledState(frame)
    Drawing:ApplyButtonBackground(frame, Theme.Color.Button.Muted)
    Drawing:ApplyBorderColor(frame.Border, Theme.Color.Border.Inner)
    Drawing:ApplyTextColor(frame.Label, Theme.Color.Text.Muted)
end

---@param parent Frame
---@param value string
---@param width number?
---@param height number?
---@return AzerothUIButtonFrame
function Button:Create(parent, value, width, height)
    ---@type AzerothUIButtonFrame
    local frame = CreateFrame("Button", nil, parent)
    frame:SetSize(width or Theme.Size.Button.Width.Normal, height or Theme.Size.Button.Height.Normal)

    local background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(frame)
    frame.Background = background
    
    Drawing:ApplyButtonBackground(frame, Theme.Color.Button.Normal)
    frame.Border = Drawing:CreateBorder(frame, 0, 1, Theme.Color.Border.Inner)

    local label = Text:CreateBody(frame, value)
    label:SetPoint("CENTER", frame, "CENTER")
    frame.Label = label
    
    frame:SetScript(
        "OnEnter",
        function(self)
            ---@cast self AzerothUIButtonFrame
            if not self:IsEnabled() then
                return
            end
            ApplyHighlightedState(self)
        end
    )

    frame:SetScript(
        "OnLeave",
        function(self)
            ---@cast self AzerothUIButtonFrame
            if not self:IsEnabled() then
                ApplyDisabledState(self)
            end
            ApplyNormalState(self)
            self.Label:ClearAllPoints()
            self.Label:SetPoint("CENTER", self, "CENTER")
        end
    )

    frame:SetScript(
        "OnMouseDown",
        function(self)
            ---@cast self AzerothUIButtonFrame
            if not self:IsEnabled() then
                return
            end
            self.Label:ClearAllPoints()
            self.Label:SetPoint("CENTER", self, "CENTER", 0, -1)
        end
    )

    frame:SetScript(
        "OnMouseUp",
        function(self)
            ---@cast self AzerothUIButtonFrame
            if not self:IsEnabled() then
                return
            end
            self.Label:ClearAllPoints()
            self.Label:SetPoint("CENTER", self, "CENTER")
        end
    )

    function frame:EnableButton()
        self:Enable()
        ApplyNormalState(self)
    end

    function frame:DisableButton()
        self:Disable()
        ApplyDisabledState(self)
    end

    return frame
end

AUI.UI.Button = Button