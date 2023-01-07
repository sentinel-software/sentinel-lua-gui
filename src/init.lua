local Types = require(script:WaitForChild("Types"))

local Sentinel: Types.Core = {
    Fusion = require(script:WaitForChild("Modules"):WaitForChild("Fusion")),
    Views = {},
    Components = {},
    Modules = {},

    Flags = {
        Initialized = false,
        Started = false
    }
}

-- Wraps a module and calls its `Init` and `Start` methods
-- Mainly used to set the module as a subclass of Sentinel
function Sentinel.WrapModule(self: Types.Core, module: table)
    module = setmetatable(module, {
        __index = Sentinel
    })

    if self.Flags.Initialized then
        local init = rawget(module, "Init")
        if init then module:Init() end
    end

    if self.Flags.Started then
        local start = rawget(module, "Start")
        if start then module:Start() end
    end

    return module
end

-- Starts all of the views and components
function Sentinel.Start(self: Types.Core)
    self.Flags.Started = true
    for _, category: string in {"Views", "Components", "Modules"} do
        for _, module: Types.Module in self[category] do
            local start = rawget(module, "Start")
            _ = start and module:Start()
        end
    end
end

-- Requires and initializes all of the views and components
-- They aren't required and initialized in the same run,
--   to make sure that they're available to other views/components
--   when they initialize
function Sentinel.Init(self: Types.Core)
    -- Require
    for _, category: string in {"Views", "Components", "Modules"} do
        local folder: Folder = script:FindFirstChild(category)
        if folder then
            for _, moduleScript: Instance in folder:GetDescendants() do
                local module: Types.Module = require(moduleScript)
                if module.__ignoreFramework then
                    module = setmetatable(module, {
                        __index = Sentinel
                    })
                    self[category][moduleScript.Name] = module
                end
            end
        end
    end

    -- Initialize
    self.Flags.Initialized = true
    for _, category: string in {"Views", "Components", "Modules"} do
        for _, module: Types.Module in self[category] do
            local init = rawget(module, "Init")
            _ = init and module:Init()

            if category == "View" then
                module.Shared = module.new()
            end
        end
    end
end

Sentinel:Init()
Sentinel:Start()

return Sentinel