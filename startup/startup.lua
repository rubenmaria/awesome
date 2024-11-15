local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local bar = require("bar")
local naughty = require("naughty")
local keys = require("keybinds")
local const = require("util.constants")
local startup = {}

local function init_theme()
	beautiful.init(const.THEME_DIRECTORY .. "theme.lua")
end

local function set_wallpaper(screen)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(screen)
		end
		gears.wallpaper.maximized(wallpaper, screen, true)
	end
end

local function handle_awesome_startup_errors()
	if awesome.startup_errors then
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, there were errors during startup!",
			text = awesome.startup_errors,
		})
	end

	do
		local in_error = false
		awesome.connect_signal("debug::error", function(err)
			if in_error then
				return
			end
			in_error = true

			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "Oops, an error happened!",
				text = tostring(err),
			})
			in_error = false
		end)
	end
end

local function spawn_user_startup_script()
	awful.spawn.with_shell(const.SCRIPTS_DIRECTORY .. "setup_zsh.sh")
	awful.spawn.with_shell(const.SCRIPTS_DIRECTORY .. "three-monitors-setup.sh")
end

local function setup_screens()
	awful.screen.connect_for_each_screen(function(current_screen)
		set_wallpaper(current_screen)
		current_screen:connect_signal("property::geometry", set_wallpaper)
		bar.tags.construct_taglist_on_screen(current_screen)
		current_screen.mypromptbox = awful.widget.prompt
		bar.wibar.construct_wibar_on_screen(current_screen)
	end)
end

local function set_keys()
	root.keys(keys.global_keys)
	root.buttons(keys.mouse_bindings)
end

function startup.init()
	init_theme()
	handle_awesome_startup_errors()
	spawn_user_startup_script()
	setup_screens()
	set_keys()
end

return startup
