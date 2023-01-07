local Types = require(script.Parent.Parent:WaitForChild("Types"))
local View: Types.View = {} :: Types.View
View.__index = View

local Fusion: Types.Fusion

function View.new()
    local self: Types.View = setmetatable({

    }, View)

    return self
end

function View.Component(self: Types.View): GuiBase
    return Fusion.New "Frame" {
        [Fusion.Children] = {
            self.Components.Component.new():Component()
        }
    }
end

function View:Start(self: Types.View)

end

function View.Init(self: Types.View)
    Fusion = self.Modules.Fusion
end