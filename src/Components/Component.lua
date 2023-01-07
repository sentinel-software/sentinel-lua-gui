local Types = require(script.Parent.Parent:WaitForChild("Types"))
local Component: Types.Component = {}
Component.__index = Component

local Fusion: Types.Fusion

function Component.new()
    local self: Types.Component = setmetatable({

    }, Component)

    return self
end

function Component.Component(self: Types.Component): UIBase
    return Fusion.New "Frame" {}
end

function Component.Start(self: Types.Component)
    
end

function Component.Init(self: Types.Component)
    Fusion = self.Modules.Fusion
end