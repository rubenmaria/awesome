local wibox = require("wibox")
local watch = require("awful.widget.watch")
local container = require("bar.widgets.simple.container")
local dpi = require("beautiful").xresources.apply_dpi

local MAIN_COLOR = "#FFFFFF"
local BACKGROUND_COLOR = "#2E2E2E"
local FONT_SIZE = dpi(12)
local WATCH_TIMEOUT = 5

-- Volume icons: "墳奔婢婢"

local volume_widget = wibox.widget({
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
	font = "JetBrainsMonoNerdFontMono " .. FONT_SIZE,
})

local function volume_string(icon, charge)
	return icon .. charge .. "%"
end

local function update_volume_widget(level)
	if level == "100" then
		volume_widget.text = volume_string("󰕾 ", level)
	elseif level == "0" then
		volume_widget.text = volume_string("󰖁 ", level)
	else
		volume_widget.text = volume_string("󰖀 ", level)
	end
end

local function update_widget(self, stdout)
	local volume_level_string = string.match(stdout, "(%d+)%%")
	update_volume_widget(volume_level_string)
end

watch("amixer get Master", WATCH_TIMEOUT, update_widget)

return container.new_container(volume_widget, MAIN_COLOR, BACKGROUND_COLOR)
