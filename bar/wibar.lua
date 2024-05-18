local awful           = require("awful")
local wibox           = require("wibox")
local calendar_widget = require("bar.widgets.calendar")
local clock_widget    = require("bar.widgets.clock")
local volume_widget   = require("bar.widgets.volume")
local battery_widget  = require("bar.widgets.battery")
local naughty         = require("naughty")
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
  local wibar_height_percent = 1 / 48
  local widget_size_percent_relative_to_wibar = 2 / 5
  local wibar_height = screen.geometry.height * wibar_height_percent
  local widget_text_size = wibar_height * widget_size_percent_relative_to_wibar
  screen.mywibox = awful.wibar({
    position = "top",
    screen = screen,
    height = wibar_height
  })


  naughty.notify({
    title = "debug",
    text = tostring(screen.geometry.height)
  })

  screen.mywibox:setup {
    align_left(
      {
        clock_widget.new_clock(widget_text_size),
        layout = wibox.layout.align.horizontal,
      }
    ),
    align_center(
      {
        screen.mytaglist,
        layout = wibox.layout.align.horizontal,
      }
    ),
    align_right(
      {
        calendar_widget,
        volume_widget,
        --battery_widget,
        layout = wibox.layout.align.horizontal
      }
    ),
    layout = wibox.layout.flex.horizontal,
  }
end

return wibar
