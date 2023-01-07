local Types = require(script.Parent.Parent.Parent:WaitForChild("Types"))
local Theme: Types.Theme = {}
Theme.__index = Theme

local Fusion

function Theme.new(themeData: Types.ThemeData)
    local self = setmetatable({}, Theme)
    self.new = nil

    for type: string, color: Color3 in themeData do
        self[type] = Fusion.Value(color)
    end

    return self
end

function Theme:Init()
    Fusion = self.Modules.Fusion
end

return Theme