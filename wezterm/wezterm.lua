-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 12
config.color_scheme = "Dracula"

config.font = wezterm.font("MesloLGL Nerd Font Mono",
  { weight = 'Bold', italic = false }
)

config.window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font({ family = "MesloLGL Nerd Font Mono", weight = "Bold" }),

    -- The size of the font in the tab bar.
    -- Default to 10.0 on Windows but 12.0 on other systems
    font_size = 12.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = "#333333",

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = "#333333",
}

config.colors = {
    tab_bar = {
        -- The color of the strip that goes along the top of the window
        -- (does not apply when fancy tab bar is in use)
        background = "#0b0022",

        -- The active tab is the one that has focus in the window
        active_tab = {
            -- The color of the background area for the tab
            bg_color = "#2b2042",
            -- The color of the text for the tab
            fg_color = "#c0c0c0",

            -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
            -- label shown for this tab.
            -- The default is "Normal"
            intensity = "Normal",

            -- Specify whether you want "None", "Single" or "Double" underline for
            -- label shown for this tab.
            -- The default is "None"
            underline = "None",

            -- Specify whether you want the text to be italic (true) or not (false)
            -- for this tab.  The default is false.
            italic = false,

            -- Specify whether you want the text to be rendered with strikethrough (true)
            -- or not for this tab.  The default is false.
            strikethrough = false,
        },

        -- Inactive tabs are the tabs that do not have focus
        inactive_tab = {
            bg_color = "#1b1032",
            fg_color = "#808080",

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over inactive tabs
        inactive_tab_hover = {
            bg_color = "#3b3052",
            fg_color = "#909090",
            italic = true,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab_hover`.
        },

        -- The new tab button that let you create new tabs
        new_tab = {
            bg_color = "#1b1032",
            fg_color = "#808080",

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over the new tab button
        new_tab_hover = {
            bg_color = "#3b3052",
            fg_color = "#909090",
            italic = true,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab_hover`.
        },
    },
}

config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"

-- MUTIPLEXTER CONFIG
-- wezterm.on('mux-startup', function()
--   local tab, pane, window = mux.spawn_window {}
--   pane:split { direction = 'Top' }
-- end)
--
-- Leader is the same as my old tmux prefix

local act = wezterm.action
local function isViProcess(pane)
    -- get_foreground_process_name On Linux, macOS and Windows,
    -- the process can be queried to determine this path. Other operating systems
    -- (notably, FreeBSD and other unix systems) are not currently supported
    return pane:get_foreground_process_name():find("n?vim") ~= nil or pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
        -- This should match the keybinds you set in Neovim.
            act.SendKey({ key = vim_direction, mods = "CTRL" }),
            pane
        )
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
    conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
    conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
    conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
    conditionalActivatePane(window, pane, "Down", "j")
end)

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
    { key = "h", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-left") },
    { key = "j", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-down") },
    { key = "k", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-up") },
    { key = "l", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-right") },
    -- navigation
    --{ key = "h", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
    --{ key = "j", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
    --{ key = "k", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
    --{ key = "l", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
    -- splitting
    {
        mods = "LEADER",
        key = '"',
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "LEADER",
        key = "%",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "LEADER",
        key = "z",
        action = wezterm.action.TogglePaneZoomState,
    },
    -- Pane resizing with LEADER + CTRL + vim directions (mimicking tmux behavior)
    -- These bindings allow you to press leader once, then hold Ctrl and repeatedly press h/j/k/l
    {
        mods = "LEADER|CTRL",
        key = "h",
        action = wezterm.action.Multiple({
            wezterm.action.AdjustPaneSize({ "Left", 5 }),
            wezterm.action.ActivateKeyTable({
                name = "resize_pane",
                one_shot = false,
            }),
        }),
    },
    {
        mods = "LEADER|CTRL",
        key = "j",
        action = wezterm.action.Multiple({
            wezterm.action.AdjustPaneSize({ "Down", 5 }),
            wezterm.action.ActivateKeyTable({
                name = "resize_pane",
                one_shot = false,
            }),
        }),
    },
    {
        mods = "LEADER|CTRL",
        key = "k",
        action = wezterm.action.Multiple({
            wezterm.action.AdjustPaneSize({ "Up", 5 }),
            wezterm.action.ActivateKeyTable({
                name = "resize_pane",
                one_shot = false,
            }),
        }),
    },
    {
        mods = "LEADER|CTRL",
        key = "l",
        action = wezterm.action.Multiple({
            wezterm.action.AdjustPaneSize({ "Right", 5 }),
            wezterm.action.ActivateKeyTable({
                name = "resize_pane",
                one_shot = false,
            }),
        }),
    },

    -- Text editing keybindings (macOS-style)
    -- CMD+Backspace: Delete entire line
    { key = "Backspace",  mods = "CMD", action = act.SendKey({ key = "u", mods = "CTRL" }) },

    -- ALT+Backspace: Delete word backward
    { key = "Backspace",  mods = "ALT", action = act.SendKey({ key = "w", mods = "CTRL" }) },

    -- Cursor movement keybindings
    -- CMD+Left: Move to beginning of line
    { key = "LeftArrow",  mods = "CMD", action = act.SendKey({ key = "a", mods = "CTRL" }) },

    -- CMD+Right: Move to end of line
    { key = "RightArrow", mods = "CMD", action = act.SendKey({ key = "e", mods = "CTRL" }) },

    -- ALT+Left: Move backward by word
    { key = "LeftArrow",  mods = "ALT", action = act.SendKey({ key = "b", mods = "ALT" }) },

    -- ALT+Right: Move forward by word
    { key = "RightArrow", mods = "ALT", action = act.SendKey({ key = "f", mods = "ALT" }) },
}

-- Key tables for repeatable actions
-- Resize mode stays active only while Ctrl is held down
config.key_tables = {
    resize_pane = {
        { key = "h",      mods = "CTRL",         action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "j",      mods = "CTRL",         action = act.AdjustPaneSize({ "Down", 5 }) },
        { key = "k",      mods = "CTRL",         action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "l",      mods = "CTRL",         action = act.AdjustPaneSize({ "Right", 5 }) },
        -- Any key without CTRL modifier exits the mode
        { key = "h",      action = "PopKeyTable" },
        { key = "j",      action = "PopKeyTable" },
        { key = "k",      action = "PopKeyTable" },
        { key = "l",      action = "PopKeyTable" },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    },
}

-- Finally, return the configuration to wezterm:
return config
