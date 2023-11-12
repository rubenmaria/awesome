local awful           = require("awful")
local wibox           = require("wibox")
local calendar_widget = require("bar.widgets.calendar")
local clock_widget    = require("bar.widgets.clock")
local volume_widget   = require("bar.widgets.volume")
local battery_widget  = require("bar.widgets.battery")

local wibar           = {}

local function align_right(widget)
  return {
    widget,
    halign = 'right',
    widget = wibox.container.place
  }
end

local function align_left(widget)
  return {
    widget,
    halign = 'left',
    widget = wibox.container.place
  }
end

local function align_center(widget)
  return {
    widget,
    halign = 'center',
    widget = wibox.container.place
  }
end

function wibar.construct_wibar_on_screen(screen)
  screen.mywibox = awful.wibar({
    position = "top",
    screen = screen,
    height = 30
  })

  screen.mywibox:setup {
    align_left(
      {
        screen.mytaglist,
        layout = wibox.layout.align.horizontal,
      }
    ),
    align_center(
      {
        clock_widget,
        layout = wibox.layout.align.horizontal,
      }
    ),
    align_right(
      {
        calendar_widget,
        volume_widget,
        battery_widget,
        layout = wibox.layout.align.horizontal
      }
    ),
    layout = wibox.layout.flex.horizontal,
  }
end

return wibar
