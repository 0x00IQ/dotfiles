-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.front_end = "OpenGL"
config.max_fps = 60
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("JetBrainsMonoNerdFont")
config.cell_width = 0.9
config.window_background_opacity = 1.0
config.prefer_egl = true
config.font_size = 12.0

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false


-- keymaps
config.keys = {
	-- Tabs
	{
		key = 'T',
		mods = 'CTRL|SHIFT|ALT',
		action = act.SpawnTab 'DefaultDomain',
	},
	{
		key = 'Q',
		mods = 'CTRL|SHIFT|ALT',
		action = wezterm.action.CloseCurrentTab {confirm = true },
	},
	-- close current pane
	{
		key = 'x',
		mods = 'CTRL|SHIFT|ALT',
		action = wezterm.action.CloseCurrentPane { confirm = true },
	},
	-- split panes
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	-- resize panes
	{
		key = "H",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	-- select panes
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	-- Debug overlay
	{ key = "D", mods = "CTRL|SHIFT|ALT", action = act.ShowDebugOverlay },
	-- toggling opacity
	{
		key = "O",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.7
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
}

-- color scheme
config.color_scheme = 'Catppuccin Mocha'

config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono", weight = "Light" }),
	active_titlebar_bg = "#0c0b0f",
}

-- config.window_decorations = "RESIZE"
config.default_prog = { "zsh" }
config.initial_cols = 80

-- and finally, return the configuration to wezterm
return config
