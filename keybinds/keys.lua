local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = require("beautiful.xresources").apply_dpi
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

--debug
local naughty = require("naughty")
--

local keys = {}
local modkey = "Mod4"
local shift = "Shift"
local control = "Control"
local programs = require("util").default_programs
local constatns = require("util.constants")

local floating_terminal_pid = nil

local function mouse_bindings()
	return {}
end

local function volume_keys()
	return gears.table.join(
		awful.key({}, "XF86AudioRaiseVolume", function()
			awful.util.spawn("amixer set Master 5%+")
		end, { description = "raise volume", group = "awesome" }),
		awful.key({}, "XF86AudioLowerVolume", function()
			awful.util.spawn("amixer set Master 5%-")
		end, { description = "raise volume", group = "awesome" })
	)
end

local function status_bar_keys()
	return gears.table.join(awful.key({ modkey, shift }, "b", function()
		local my_screen = awful.screen.focused()
		my_screen.mywibox.visible = not my_screen.mywibox.visible
	end, { description = "toggle statusbar" }))
end

local function tag_keys()
	return gears.table.join(
		awful.key({ modkey }, "Left", awful.tag.viewprev, {
			description = "view previous",
			group = "tag",
		}),
		awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
		awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" })
	)
end

local function screen_focus_keys()
	return gears.table.join(
		awful.key({ modkey }, "l", function()
			awful.screen.focus_relative(1)
		end, {
			description = "focus the next screen",
			group = "screen",
		}),
		awful.key({ modkey }, "h", function()
			awful.screen.focus_relative(-1)
		end, {
			description = "focus the previous screen",
			group = "screen",
		})
	)
end

local function client_global_focus_keys()
	return gears.table.join(
		awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
			description = "jump to urgent client",
			group = "client",
		}),
		awful.key({ modkey }, "Tab", function()
			awful.client.focus.byidx(-1)
			if client.focus ~= nil then
				client.focus:raise()
			end
		end, { description = "go back", group = "client" })
	)
end

local function program_launch_keys()
	return gears.table.join(
		awful.key({ modkey }, "b", function()
			awful.spawn(programs.browser)
		end, {
			description = "open a browser",
			group = "launcher",
		}),
		awful.key({ modkey }, "t", function()
			awful.spawn(programs.terminal)
		end, {
			description = "open terminal",
			group = "launcher",
		}),
		awful.key({ modkey }, "f", function()
			local is_floating_terminal = function(c)
				return c.pid == floating_terminal_pid
			end
			local floating_terminal_client = nil

			for c in awful.client.iterate(is_floating_terminal) do
				floating_terminal_client = c
			end

			if floating_terminal_client == nil then
				floating_terminal_pid = awful.spawn(programs.terminal, {
					floating = true,
					width = dpi(700),
					height = dpi(700),
					placement = awful.placement.centered,
				})
				return
			end

			if floating_terminal_client.minimized then
				floating_terminal_client.minimized = false
				client.focus = floating_terminal_client
				floating_terminal_client:move_to_screen(awful.screen.focused())
				floating_terminal_client:move_to_tag(awful.tag.selected(awful.screen.focused()))
				floating_terminal_client:raise()
				return
			end

			floating_terminal_client.minimized = true
		end, {
			description = "open the floating terminal",
			group = "launcher",
		}),
		awful.key({ modkey }, "z", function()
			local script_path = constatns.SCRIPTS_DIRECTORY .. "/zathura-search.sh"
			awful.spawn(programs.terminal .. " -e " .. script_path, {
				floating = true,
				width = dpi(800),
				height = dpi(300),
				placement = awful.placement.centered,
			})
		end, {
			description = "open a pdf viewer",
			group = "launcher",
		}),
		awful.key({ modkey, shift }, "v", function()
			awful.spawn.with_shell(
				gears.filesystem.get_configuration_dir() .. "monitors/monitor-scripts/vga-laptop-res.sh"
			)
		end, {
			description = "setup vga monitor mirror with right resolution",
			group = "launcher",
		}),
		awful.key({ control, modkey, shift }, "w", function()
			awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/windows-reboot.sh")
		end, {
			description = "setup vga monitor mirror with right resolution",
			group = "launcher",
		}),
		awful.key({ modkey }, "e", function()
			awful.spawn(programs.ide)
		end, {
			description = "open a IDE",
			group = "launcher",
		})
	)
end

local function awesome_keys()
	return gears.table.join(
		awful.key({ modkey, control }, "r", awesome.restart, {
			description = "reload awesome",
			group = "awesome",
		}),
		awful.key({ modkey, shift }, "q", awesome.quit, {
			description = "quit awesome",
			group = "awesome",
		}),
		awful.key({ modkey }, "d", function()
			menubar.show()
		end, {
			description = "Program launcher",
			group = "launcher",
		}),
		awful.key({ modkey }, "p", function()
			awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "../rofi/scripts/powermenu_t2")
		end, {
			description = "Show powermenu",
			group = "launcher",
		}),
		awful.key({ modkey }, "s", function()
			awful.spawn.with_shell("flameshot gui")
		end, {
			description = "Show powermenu",
			group = "launcher",
		}),
		awful.key({ modkey, shift }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" })
	)
end

local function client_keys()
	return gears.table.join(
		awful.key({ modkey, control }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),
		awful.key({ modkey, shift }, "h", function(c)
			awful.client.swap.bydirection("left", c)
		end, { description = "swap with left client", group = "client" }),
		awful.key({ modkey, shift }, "l", function(c)
			awful.client.swap.bydirection("right", c)
		end, { description = "swap with right client", group = "client" }),
		awful.key({ modkey, shift }, "c", function(c)
			c:kill()
		end, { description = "close", group = "client" }),
		awful.key({ modkey, shift }, "l", function(c)
			c:move_to_screen()
		end, { description = "move to screen", group = "client" }),
		awful.key({ modkey, shift }, "h", function(c)
			c:move_to_screen(c.screen.index - 1)
		end, { description = "move to screen", group = "client" }),
		awful.key({ modkey, shift }, "Left", function(c)
			c:relative_move(0, 0, -20, 0)
		end, { description = "Make client smaller width", group = "client" }),
		awful.key({ modkey }, "space", function(c)
			c.floating = not c.floating
		end, { description = "toggle floating mode", group = "client" }),
		awful.key({ modkey, shift }, "Up", function(c)
			c:relative_move(0, 0, 0, -20)
		end, { description = "Make client smaller width", group = "client" }),
		awful.key({ modkey, shift }, "Down", function(c)
			c:relative_move(0, 0, 0, 20)
		end, { description = "Make client smaller width", group = "client" }),
		awful.key({ modkey, shift }, "Right", function(c)
			c:relative_move(0, 0, 20, 0)
		end, { description = "Make client smaller width", group = "client" })
	)
end

local function client_mouse_buttons()
	return {}
end

local function tag_control_keys()
	local global_keys
	for i = 1, 9 do
		global_keys = gears.table.join(
			global_keys,
			awful.key({ modkey }, "#" .. i + 9, function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end, { description = "view tag #" .. i, group = "tag" }),
			awful.key({ modkey, shift }, "#" .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
						tag:view_only()
					end
				end
			end, {
				description = "move focused client to tag #" .. i,
				group = "tag",
			})
		)
	end
	return global_keys
end

keys.mouse_bindings = mouse_bindings()
keys.global_keys = gears.table.join(
	volume_keys(),
	tag_keys(),
	status_bar_keys(),
	screen_focus_keys(),
	program_launch_keys(),
	client_global_focus_keys(),
	awesome_keys(),
	tag_control_keys()
)
keys.client_keys = client_keys()
keys.client_buttons = client_mouse_buttons()

return keys
