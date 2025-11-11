-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
-- local config = {}
-- local mux = wezterm.mux
local act = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Disable Check for Updates
-- config.show_update_window = false
config.check_for_updates = false
config.check_for_updates_interval_seconds = 86400

-- Scroll Bar
config.enable_scroll_bar = true
config.scrollback_lines = 5000000

-- Dead Keys
--config.use_dead_keys = false
--config.use_ime = f_night

-- Window defaults
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_buttons = { "Hide", "Maximize", "Close" }
config.initial_cols = 140
config.initial_rows = 40

-- Customization - Themes, Colors & Fonts
config.color_scheme = "tokyonight_night" -- Options night/day
config.use_fancy_tab_bar = true

-- Tab bar
config.window_frame = {
	font = wezterm.font({ family = "Hack Nerd Font", weight = "Regular" }),
	font_size = 10.0,
}

-- Font
-- config.font = wezterm.font_with_fallback {
--   { family = "Hack Nerd Font", size = 10 },
-- }
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 10

-- Background Opacity
config.window_background_opacity = 0.98

-- Panes Active/Inactive
config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.6,
}

-- When new output change tab title foreground color

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

-- This event is triggered when the tab title needs to be changed
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- local variables
	local title = tab_title(tab)
	local has_unseen_output = false
	local is_zoomed = false
	-- Check for unseen output and zoomed panes
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
		end
		if pane.is_zoomed then
			is_zoomed = true
		end
	end
	-- Always show the zoom indicator, even if there's no unseen output or is active tab
	title = title .. (is_zoomed and " " .. wezterm.nerdfonts.cod_zoom_in or "")
	-- if tab is active, just return the title and end the function
	if tab.is_active then
		return {
			{ Text = " " .. title .. " " },
		}
	end
	-- if tab is not active, and has unseen output, return the title with a different color
	if has_unseen_output then
		return {
			{ Foreground = { Color = " 	#fbd9d3" } },
			{ Text = " " .. title .. " *" },
		}
	end
	-- otherwise just return the title
	return title
end)

-- Shortcuts
config.leader = { key = "Space", mods = "SUPER" }
config.keys = {
	-- Panes
	{ key = "h", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "s", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "0", mods = "CTRL", action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },

	-- { key = 'h', mods = 'LEADER', action = act.AdjustPaneSize { 'Left',  10 } },
	-- { key = 'j', mods = 'LEADER', action = act.AdjustPaneSize { 'Down',  10 } },
	-- { key = 'k', mods = 'LEADER', action = act.AdjustPaneSize { 'Up',    10 } },
	-- { key = 'l', mods = 'LEADER', action = act.AdjustPaneSize { 'Right', 10 } },
	-- Tabs
	{ key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "l", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "h", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "m", mods = "CTRL|SHIFT", action = wezterm.action.ShowTabNavigator },
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(" " .. line .. " ")
				end
			end),
		}),
	},
}

-- and finally, return the configuration to wezterm
return config
