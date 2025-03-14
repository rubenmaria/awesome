local watch = require("awful.widget.watch")
local container = require("bar.widgets.simple.container")
local dpi = require("beautiful").xresources.apply_dpi

local MAIN_COLOR = "#FFFFFF"
local BACKGROUND_COLOR = "#2E2E2E"
local FONT_SIZE = dpi(15)
local WATCH_TIMEOUT = 1

-- Volume icons: "墳奔婢婢"

local function volume_string(icon, charge)
	return icon .. "  " .. charge .. "%"
end

local function update_volume_widget(widget, level)
	if level == "100" then
		widget:set_text(volume_string("󰕾 ", level))
	elseif level == "0" then
		widget:set_text(volume_string("󰖁 ", level))
	else
		widget:set_text(volume_string("󰖀 ", level))
	end
end

local function update_widget(widget, stdout)
	local volume_level_string = string.match(stdout, "(%d+)%%")
	update_volume_widget(widget, volume_level_string)
end

local volume_widget = watch("amixer get Master", WATCH_TIMEOUT, update_widget)
volume_widget:set_font("JetBrainsMonoNerdFontMono " .. FONT_SIZE)

return container.new_container(volume_widget, MAIN_COLOR, BACKGROUND_COLOR)
