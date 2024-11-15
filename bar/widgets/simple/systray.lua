local wibox = require("wibox")
local container = require("bar.widgets.simple.container")

local MAIN_COLOR = "#FFFFFF"
local BACKGROUND_COLOR = "#2E2E2E"
local widget = wibox.widget.systray()

return container.new_container(widget, MAIN_COLOR, BACKGROUND_COLOR)
