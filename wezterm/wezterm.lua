local wezterm = require("wezterm")
local config = {}
local workspace_history = {}

-- Font and window settings
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "RESIZE"
-- disabling ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Tab settings
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 40
config.hide_tab_bar_if_only_one_tab = false

-- Color and rendering settings
config.color_scheme = "Everforest Dark (Gogh)"

-- Speed up rendering
config.max_fps = 120

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

local function get_projects_from_directory(path)
	local projects = {
		{ id = wezterm.home_dir .. "/.config", label = "config" },
	}

	local handle = io.popen("ls -d " .. path .. "/*/")
	if handle then
		for dir in handle:lines() do
			local project_name = dir:match("^.*/([^/]+)/$")
			if project_name then
				table.insert(projects, { id = dir, label = project_name })
			end
		end
		handle:close()
	end

	-- Move the last two workspaces to the top of the list
	table.sort(projects, function(a, b)
		-- Index of a and b in workspace_history
		local a_index, b_index
		for i, ws in ipairs(workspace_history) do
			if ws.label == a.label then
				a_index = i
			end
			if ws.label == b.label then
				b_index = i
			end
		end

		-- Last two workspaces should come first
		if a_index and b_index then
			return a_index < b_index
		elseif a_index then
			return true
		elseif b_index then
			return false
		else
			-- If neither is in history, sort alphabetically by label
			return a.label < b.label
		end
	end)

	return projects
end

-- Function to update workspace history for toggling
local function update_workspace_history(id, label)
	-- Remove the current workspace from history if it already exists
	for i, ws in ipairs(workspace_history) do
		if ws.label == label then
			table.remove(workspace_history, i)
			break
		end
	end

	-- Insert the current workspace at the top
	table.insert(workspace_history, 1, { id = id, label = label })

	-- Keep only the last two workspaces for toggling
	if #workspace_history > 2 then
		table.remove(workspace_history, 3) -- Remove the oldest one
	end
end

-- Function to switch between projects as workspaces
wezterm.on("switch-to-project", function(window, pane)
	local projects = get_projects_from_directory("/Users/nikola/projects")

	-- Show the launcher to let the user fuzzy search and select a project workspace
	window:perform_action(
		wezterm.action.InputSelector({
			action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
				if not id and not label then
					wezterm.log_info("cancelled")
				else
					update_workspace_history(id, label)

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
			choices = projects,
			fuzzy = true,
		}),
		pane
	)
end)

-- Keybindings
-- config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "-", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "/", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "f", mods = "ALT", action = wezterm.action.ToggleFullScreen },
	{ key = "p", mods = "ALT", action = wezterm.action.PaneSelect({ alphabet = "1234567890" }) },
	{ key = "x", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "X", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "n", mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Multiple({
			wezterm.action.SpawnCommandInNewTab({
				args = { "ssh", "nidzola@workstation" }, -- static IP for workstation is (in local network): 192.168.50.202
				domain = "CurrentPaneDomain",
				label = "Workstation",
			}),
		}),
	},
}

-- Event handlers
wezterm.on("format-tab-title", function(tab)
	local cwd = string.match(tab.active_pane.current_working_dir.file_path, "/([^/]*)$")
	local host = tab.active_pane.current_working_dir.host or ""
	if host == "osx.local" or host == "macbook" then
		return { { Text = " " .. cwd .. "  " } }
	end
	return { { Text = " 󰇅  Workstation " } }
end)

wezterm.on("update-right-status", function(window)
	window:set_right_status(wezterm.format({ { Text = "Workspace: " .. window:active_workspace() .. " " } }))
end)

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
