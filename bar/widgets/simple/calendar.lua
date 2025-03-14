local wibox = require("wibox")
local container = require("bar.widgets.simple.container")
local dpi = require("beautiful").xresources.apply_dpi

local MAIN_COLOR = "#FFFFFF"
local BACKGROUND_COLOR = "#2E2E2E"
local FONT_SIZE = dpi(15)

local calendar_widget = wibox.widget.textclock(
	'<span color="#e49c18" font="JetbrainsMono Nerd Font ' .. FONT_SIZE .. '">   %d.%m.%y</span>',
	5
)
return container.new_container(calendar_widget, MAIN_COLOR, BACKGROUND_COLOR)
