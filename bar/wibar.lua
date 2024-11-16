local awful = require("awful")
local wibox = require("wibox")
local calendar_widget = require("bar.widgets.simple.calendar")
local clock_widget = require("bar.widgets.simple.clock")
local volume_widget = require("bar.widgets.simple.volume")
local battery_widget = require("bar.widgets.simple.battery")
local systray_widget = require("bar.widgets.simple.systray")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local screen_info = require("monitors")
local wibar = {}

local function taglist_widget(screen)
	return {
		{
			screen.mytaglist,
			left = dpi(5),
			right = dpi(5),
			bottom = dpi(5),
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
		bg = beautiful.bg_normal,
		shape = gears.shape.rounded_bar,
	}
end

local function align_right(widget)
	return {
		widget,
		halign = "right",
		widget = wibox.container.place,
	}
end

local function align_left(widget)
	return {
		widget,
		halign = "left",
		widget = wibox.container.place,
	}
end

local function align_center(widget)
	return {
		widget,
		halign = "center",
		widget = wibox.container.place,
	}
end

function wibar.construct_wibar_on_screen(screen)
	screen.mywibox = awful.wibar({
		position = "top",
		screen = screen,
		height = dpi(30),
		bg = beautiful.bg_normal .. "0",
	})
	screen.mywibox:setup({
		align_left({
			clock_widget,
			screen == screen_info.primary and systray_widget or nil,
			layout = wibox.layout.align.horizontal,
		}),
		align_center({
			layout = wibox.layout.align.horizontal,
			taglist_widget(screen),
		}),
		align_right({
			calendar_widget,
			volume_widget,
			battery_widget,
			layout = wibox.layout.align.horizontal,
		}),
		layout = wibox.layout.flex.horizontal,
	})
end

return wibar
