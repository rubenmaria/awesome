local gears            = require("gears")
local wibox            = require("wibox")
local watch            = require("awful.widget.watch")
local naughty          = require("naughty")


local timeout          = 1
local main_color       = "#FFFFFF"
local background_color = "#2E2E2E"
local widget_container = wibox.container
local size             = 12
local volume_script    = "amixer get Master"
local volume_icons     = "墳奔婢婢"
local math_alpha       = "𝛼𝛽𝛾𝛿𝜀𝜁𝜂𝜃𝜄𝜅𝜆𝜋𝜒𝜓,𝜶𝜷𝜸𝜹𝜺𝜻𝜼𝜽𝜾𝜿𝝀𝝅𝝍"
local math_num_lines   = "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"

local volume_widget    = wibox.widget({
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
  font = "JetbrainsMono Nerd Font " .. size,
})

local function volume_string(icon, charge)
  return icon .. "  " .. charge .. "%"
end

local function update_volume_widget(level)
  if level == "100" then
    volume_widget.text = volume_string("墳", level)
  elseif level == "0" then
    volume_widget.text = volume_string("婢", level)
  else
    volume_widget.text = volume_string("奔", level)
  end
end

local function update_widget(self, level)
  local volume_level_string = string.match(level, "(%d+)%%")
  update_volume_widget(volume_level_string)
end

watch(volume_script, timeout, update_widget)

widget_container = {
  {
    {
      {
        widget = volume_widget,
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
