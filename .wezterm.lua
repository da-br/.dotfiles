local wezterm = require 'wezterm'

-- The only required line is this one.
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
-- Some empty tables for later use
local config = {}
local mouse_bindings = {}
local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe" }
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })
  table.insert(launch_menu, {
    label = 'Pwsh',
    args = { 'pwsh.exe', '-NoLogo' },
  })
else
  config.default_prog = { '/usr/local/bin/zsh' }
end

config.launch_menu = launch_menu
config.audible_bell = "Disabled"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"
config.enable_tab_bar = true
config.window_decorations = "RESIZE"   -- Show window borders and buttons
config.font_size = 12.0               -- Set the font size to 12
config.line_height = 1               -- Set the line height for better readability

config.leader = { key = "a", mods = "CTRL"  }

-- CTRL + SHIFT + ARROW = switch panes
local mykeys = {}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(mykeys, {
		key = tostring(i),
		mods = "LEADER",
		action = act({ ActivateTab = i - 1 }),
	})
end

-- wezterm.on('update-right-status', function(window, pane)
--   local leader = ''
--   if window:leader_is_active() then
--     leader = 'LEADER'
--   end
--   window:set_right_status(leader)
-- end)

table.insert(mykeys, { key = "n", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) })

table.insert(mykeys, { key = "f", mods = "LEADER", action = "ToggleFullScreen" })

table.insert(mykeys, { key = "[", mods = "LEADER", action = act.MoveTabRelative(-1) })
table.insert(mykeys, { key = "]", mods = "LEADER", action = act.MoveTabRelative(1) })

table.insert(mykeys, { key = "H", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) })
table.insert(
	mykeys,
	{ key = "V", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) }
)

table.insert(mykeys, { key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) })
table.insert(mykeys, { key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) })
table.insert(mykeys, { key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) })
table.insert(mykeys, { key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) })

table.insert(mykeys, { key = "h", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 1 }) })
table.insert(mykeys, { key = "j", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 1 }) })
table.insert(mykeys, { key = "k", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 1 }) })
table.insert(mykeys, { key = "l", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 1 }) })

table.insert(mykeys, { key = "c", mods = "LEADER", action = act.ActivateCopyMode })

table.insert(mykeys, { key = "q", mods = "LEADER", action = act.QuickSelect })

table.insert(mykeys, { key = "s", mods = "LEADER", action = act.Search({ CaseSensitiveString = "" }) })

config.font = wezterm.font("JetBrains Mono", { weight = "Medium", italic = false, stretch = "Normal" })
config.keys = mykeys

return config
