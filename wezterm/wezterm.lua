local wezterm = require("wezterm")
local config = {}

-- Font and window settings
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Tab settings
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 40

-- Color and rendering settings
config.color_scheme = "Everforest Dark (Gogh)"

-- Colors
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#2f383e",
			fg_color = "#d3c6aa",
		},
	},
}

-- config.color_scheme = "Everforest Dark Hard (Gogh)"
config.front_end = "WebGpu"
config.freetype_load_flags = "NO_HINTING"
config.freetype_load_target = "Normal"
config.freetype_render_target = "Normal"

-- Miscellaneous settings
config.automatically_reload_config = true
config.use_dead_keys = false

-- Keybindings
config.keys = {
	{ key = "v", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "p", mods = "ALT", action = wezterm.action.PaneSelect({ alphabet = "1234567890" }) },
	-- { key = "o", mods = "ALT", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{
		key = "o",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			-- TODO: confiure this list dynamically
			local home = wezterm.home_dir
			local workspaces = {
				{ id = home .. "/.config", label = "config" },
				{ id = home .. "/projects/admin-app", label = "admin-app" },
				{ id = home .. "/projects/go-api", label = "go-api" },
				{ id = home .. "/projects/service-partner", label = "service-partner" },
				{ id = home .. "/projects/terrafrom", label = "terrafrom" },
				{ id = home .. "/projects/service-partner-frontend", label = "service-partner-frontend" },
				{ id = home .. "/projects/graphql", label = "graphql" },
				{ id = home .. "/projects/foundatinon", label = "foundatinon" },
				{ id = home .. "/projects/web-app", label = "web-app" },
				{ id = home .. "/projects/anyservice-api", label = "anyservice-api" },
				{ id = home .. "/projects/anyservice-fe-v2", label = "anyservice-frontend" },
				{ id = home .. "/projects/bin", label = "bin" },
			}
			window:perform_action(
				wezterm.action.InputSelector({
					action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
						if not id and not label then
							wezterm.log_info("cancelled")
						else
							wezterm.log_info("id = " .. id)
							wezterm.log_info("label = " .. label)
							inner_window:perform_action(
								wezterm.action.SwitchToWorkspace({
									name = label,
									spawn = {
										label = "Workspace: " .. label,
										cwd = id,
									},
								}),
								inner_pane
							)
						end
					end),
					title = "Choose Workspace",
					choices = workspaces,
					fuzzy = true,
				}),
				pane
			)
		end),
	},
	{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{
		key = "n",
		mods = "ALT",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Text = "Enter name for workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(wezterm.action.SwitchToWorkspace({ name = line }), pane)
				end
			end),
		}),
	},
	{
		key = "t",
		mods = "ALT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

-- Event handlers
wezterm.on("format-tab-title", function(tab)
	local cwd = string.match(tab.active_pane.current_working_dir.file_path, "/([^/]*)$")
	return { { Text = " " .. cwd .. "  " } }
end)

wezterm.on("update-right-status", function(window)
	window:set_right_status(wezterm.format({ { Text = "Workspace: " .. window:active_workspace() .. " " } }))
end)

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
