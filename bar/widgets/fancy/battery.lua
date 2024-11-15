local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

ASSET_DIR = gears.filesystem.get_configuration_dir() .. "widgets/assets"

local last_battery_check = os.time()
local timeout            = 10
local main_color         = "#FFFFFF"
local background_color   = "#2E2E2E"
local widget_container   = wibox.container
local size               = 12
local notification

local battery_widget = wibox.widget({
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
  font =  "JetbrainsMono Nerd Font " .. size,
  markup = "",
  ignore_markup = false
})

local function show_battery_warning()
    local warning_msg_title    = 'Houston, we have a problem'
    local warning_msg_text     = 'Battery is dying'
    local warning_msg_position = 'bottom_right'
    local warning_msg_icon     =  ASSET_DIR .. '/spaceman.jpg'
    naughty.notify {
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
    }
end

local function battery_string(icon, charge)
  return icon .. "  ".. charge .. "%"
end

local function update_battery_widget(charge, status)
  local warning_last_updated =
    os.difftime(os.time(), last_battery_check)
  if status == 'Charging' then
    battery_widget.text = battery_string("", charge)
  elseif charge == 100 then
    battery_widget.text = battery_string("", charge)
  elseif charge > 50 then
    battery_widget.text = battery_string("", charge)
  elseif charge > 30 then
    battery_widget.text = battery_string("", charge)
  elseif charge > 10 then
    battery_widget.text = battery_string("", charge)
  else
    if warning_last_updated > 300 then
      last_battery_check = os.time()
      show_battery_warning()
    end
    battery_widget.text = battery_string("", charge)
  end
end


local function update_widget(self, stdout)
    local charge = 0
    local status = ""
    for s in stdout:gmatch("[^\r\n]+") do
        local cur_status, charge_str, _ = string.match(s, '.+: (%a+%s*%a+), (%d?%d?%d)%%,?(.*)')
        if cur_status ~= nil and charge_str ~= nil then
            local cur_charge = tonumber(charge_str)
            if cur_charge > charge then
                status = cur_status
                charge = cur_charge
           end
        end
    end
    update_battery_widget(charge, status)
end

watch("acpi", timeout, update_widget)


local function show_battery_status()
  awful.spawn.easy_async([[bash -c 'acpi']],
    function(stdout, _, _, _)
      naughty.destroy(notification)
      notification = naughty.notify {
        text = stdout,
        title = "Battery status",
        timeout = 5,
        width = 200,
      }
    end)
end

battery_widget:connect_signal('button::press', function(_, _, _, button)
    if (button == 1) then show_battery_status() end
end)

widget_container = {
	{
		{
			{
				widget = battery_widget,
			},
			left = 12,
			right = 10,
			top = 0,
			bottom = 0,
			widget = wibox.container.margin,
		},
		shape = gears.shape.rounded_bar,
		fg = main_color,
		bg = background_color,
		widget = wibox.container.background,
	},
	spacing = 5,
	layout = wibox.layout.fixed.horizontal,
}

return widget_container
