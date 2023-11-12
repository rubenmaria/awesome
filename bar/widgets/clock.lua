local gears            = require("gears")
local wibox            = require("wibox")
local naughty          = require("naughty")
local main_color       = "#FFFFFF"
local background_color = "#2E2E2E"
local widget_container = wibox.container
local size             = 12
local text_clock = wibox.widget.textclock(
    '<span color="#e49c18" font="JetbrainsMono Nerd Font '.. size ..
    '"> %H:%M </span>',
    5
  )


widget_container = {
  {
    {
      {
        widget = text_clock,
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
