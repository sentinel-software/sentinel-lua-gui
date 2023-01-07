local Types = require(script.Parent.Parent:WaitForChild("Types"))
local MainView: Types.MainView = {} :: Types.MainView
MainView.__index = MainView

local Fusion: Types.Fusion
local ThemeManager: Types.ThemeManager

function MainView.new()
    local self: Types.View = setmetatable({
        Minimized = Fusion.Value(false)
    }, MainView)

    return self
end

function MainView.Component(self: Types.MainView): GuiBase
    return Fusion.New "Frame" {
        Name = "MainView",
        Position = UDim2.new(.5, 0, .5, 0),
        Size = UDim2.new(0, 400, 0, 300),
        BackgroundColor3 = ThemeManager:GetThemeColorTweened("Background"),

        [Fusion.Children] = {
            Fusion.New "Frame" {
                Name = "Topbar",
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundColor3 = ThemeManager:GetThemeColorTweened("Foreground")
            }
        }
    }
end

function MainView.Start(self: Types.MainView)
    
end

function MainView.Init(self: Types.MainView)
    Fusion = self.Modules.Fusion
    ThemeManager = self.Modules.ThemeManager
end