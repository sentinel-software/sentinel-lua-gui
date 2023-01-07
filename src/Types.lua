local Fusion = require(script.Parent:WaitForChild("Modules"):WaitForChild("Fusion"):WaitForChild("PubTypes"))

-- Core Types
export type Core = {
    Fusion: Fusion,
    Views: {
        View: View,
        MainView: MainView
    },
    Components: {
        Component: Component
    },
    Modules: {
        Fusion: Fusion,
        ThemeManager: ThemeManager
    },
    Flags: {
        Initialized: boolean,
        Started: boolean
    }
}

export type Module = Core & {
    Start: (self: Module) -> nil,
    Init: (self: Module) -> nil,
}

export type ModuleClass = Module & {
    __index: Module,
    new: (...any) -> Module,
}

export type View = Module & {
    Shared: Module,
    Component: (self: View) -> GuiBase
}

export type Component = Module & {
    Component: (self: View) -> GuiBase
}

-- Module (and submodule) types
export type ThemeManager = Core & {
    CurrentTheme: Fusion.Value<Theme>?,
    Themes: {Theme},
    GetCurrentTheme: (self: ThemeManager) -> Theme?,
    GetTheme: (self: ThemeManager) -> Theme?,
    GetThemeColor: (self: ThemeManager, color: string) -> Fusion.Value<Color3>,
    GetThemeColorTweened: (self: ThemeManager, color: string) -> Fusion.Tween<Fusion.Value<Color3>>
}

export type Theme = ThemeManager & ThemeData & {
    new: (...any) -> Theme,
}

export type ThemeData = {
    Foreground: Color3,
    Background: Color3,
    Text: Color3
}

export type Fusion = {
	version: Fusion.Version,

	New: (className: string) -> ((propertyTable: Fusion.PropertyTable) -> Instance),
	Hydrate: (target: Instance) -> ((propertyTable: Fusion.PropertyTable) -> Instance),
	Ref: Fusion.SpecialKey,
	Cleanup: Fusion.SpecialKey,
	Children: Fusion.SpecialKey,
	Out: Fusion.SpecialKey,
	OnEvent: (eventName: string) -> Fusion.SpecialKey,
	OnChange: (propertyName: string) -> Fusion.SpecialKey,

	Value: <T>(initialValue: T) -> Fusion.Value<T>,
	Computed: <T>(callback: () -> T, destructor: (T) -> ()?) -> Fusion.Computed<T>,
	ForPairs: <KI, VI, KO, VO, M>(inputTable: Fusion.CanBeState<{[KI]: VI}>, processor: (KI, VI) -> (KO, VO, M?), destructor: (KO, VO, M?) -> ()?) -> Fusion.ForPairs<KO, VO>,
	ForKeys: <KI, KO, M>(inputTable: Fusion.CanBeState<{[KI]: any}>, processor: (KI) -> (KO, M?), destructor: (KO, M?) -> ()?) -> Fusion.ForKeys<KO, any>,
	ForValues: <VI, VO, M>(inputTable: Fusion.CanBeState<{[any]: VI}>, processor: (VI) -> (VO, M?), destructor: (VO, M?) -> ()?) -> Fusion.ForValues<any, VO>,
	Observer: (watchedState: Fusion.StateObject<any>) -> Fusion.Observer,

	Tween: <T>(goalState: Fusion.StateObject<T>, tweenInfo: TweenInfo?) -> Fusion.Tween<T>,
	Spring: <T>(goalState: Fusion.StateObject<T>, speed: number?, damping: number?) -> Fusion.Spring<T>,

	cleanup: (...any) -> (),
	doNothing: (...any) -> ()
}

-- View types
export type MainView = View & {
    Minimized: Fusion.Value<boolean>
}

-- Component types

return nil