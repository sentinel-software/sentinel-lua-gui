local Types = require(script.Parent.Parent:FindFirstChild("Types"))
local ThemeManager: Types.ThemeManager = {}
ThemeManager.__index = ThemeManager

local Theme = require(script:WaitForChild("Theme"))
local Fusion: Types.Fusion

function ThemeManager.new()
    local self: Types.ThemeManager = setmetatable({
        CurrentTheme = nil,
        Themes = {}
    }, ThemeManager)

    return self
end

function ThemeManager.GetCurrentTheme(self: Types.ThemeManager)
    return self.CurrentTheme
end

function ThemeManager.SetTheme(self: Types.ThemeManager, theme: string)
    local theme = self:GetTheme(theme)
    for k,v in theme do
        theme[k] = Fusion.Value(v)
    end
    self.CurrentTheme = theme
end

function ThemeManager.GetTheme(self: Types.ThemeManager, theme: string)
    return self.Themes[theme]
end

function ThemeManager.GetColor(self: Types.ThemeManager, color: string)
    if self.CurrentTheme then
        return self.CurrentTheme[color]
    end
end

function ThemeManager.Init(self: Types.ThemeManager)
    Fusion = self.Modules.Fusion

    self:WrapModule(Theme)

    for _, themeModule: Instance in script.Themes:GetChildren() do
        if themeModule.Name ~= "Template" then
            local themeData: Types.Theme = require(themeModule)
            self.Themes[themeModule.Name] = Theme.new(themeData)
        end
    end

    self.CurrentTheme = self:GetTheme("Dark")
end