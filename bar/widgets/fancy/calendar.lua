local wibox       = require("wibox")
local gears       = require("gears")
local compononets = require("bar.widgets.components")
local const       = require("util.constants")


local date = {}


local function set_date(date_widget)
    date_widget.container.widget_layout.text:set_text(
      os.date("%a, %b %d")
    )
end


function date.new_calendar()
  local date_widget = {
    id = "text",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
  }
  local date_widget_container = compononets.bar_container_with_icon(
    date_widget,
    "Grey900",
    "Blue900",
    "Grey900",
    const.ICONS_DIRECTORY .. "date/calendar.svg"
  )
  gears.timer {
    timeout   = 60,
    autostart = true,
    call_now  = true,
    call_back = function ()
      set_date(date_widget)
    end
  }
  return date_widget_container
end


return date
