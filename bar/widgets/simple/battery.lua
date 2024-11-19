local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local constants = require("util.constants")
local container = require("bar.widgets.simple.container")

local FONT_SIZE = 10
local MAIN_COLOR = "#FFFFFF"
local BACKGROUND_COLOR = "#2E2E2E"
local WATCH_TIMEOUT = 5

local function show_battery_warning()
	local warning_msg_title = "Houston, we have a problem"
	local warning_msg_text = "Battery is dying"
	local warning_msg_position = "bottom_right"
	local warning_msg_icon = constants.ASSETS_DIRECTORY .. "/spaceman.jpg"
	naughty.notify({
		icon = warning_msg_icon,
		icon_size = 100,
		text = warning_msg_text,
		title = warning_msg_title,
		timeout = 25, -- show the warning for a longer time
		hover_timeout = 0.5,
		position = warning_msg_position,
		bg = "#F06060",
		fg = "#EEE9EF",
		width = 300,
	})
end

local function battery_string(icon, charge)
	return icon .. "  " .. charge .. "%"
end

local function update_battery_widget(widget, charge, status)
	local last_battery_check = os.time()
	local warning_last_updated = os.difftime(os.time(), last_battery_check)
	if status == "Charging" then
		widget:set_text(battery_string("", charge))
	elseif charge == 100 then
		widget:set_text(battery_string("", charge))
	elseif charge > 50 then
		widget:set_text(battery_string("", charge))
	elseif charge > 30 then
		widget:set_text(battery_string("", charge))
	elseif charge > 10 then
		widget:set_text(battery_string("", charge))
	else
		if warning_last_updated > 300 then
			last_battery_check = os.time()
			show_battery_warning()
		end
		widget:set_text(battery_string("", charge))
	end
end

local function update_widget(widget, stdout)
	local charge = 0
	local status = ""
	for s in stdout:gmatch("[^\r\n]+") do
		local cur_status, charge_str, _ = string.match(s, ".+: (%a+%s*%a+), (%d?%d?%d)%%,?(.*)")
		if cur_status ~= nil and charge_str ~= nil then
			local cur_charge = tonumber(charge_str)
			if cur_charge ~= nil and cur_charge > charge then
				status = cur_status
				charge = cur_charge
			end
		end
	end
	update_battery_widget(widget, charge, status)
end

local battery_widget = watch("acpi", WATCH_TIMEOUT, update_widget)
battery_widget:set_font("JetbrainsMono Nerd Font " .. FONT_SIZE)

local function show_battery_status()
	awful.spawn.easy_async([[bash -c 'acpi']], function(stdout, _, _, _)
		naughty.notify({
			text = stdout,
			title = "Battery status",
			timeout = 5,
			width = 200,
		})
	end)
end

battery_widget:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		show_battery_status()
	end
end)

return container.new_container(battery_widget, MAIN_COLOR, BACKGROUND_COLOR)
