local wibox            = require("wibox")
local components       = require("bar.widgets.components")
local const            = require("util.constants")
local clock = {}


clock.new_clock = function()
  local text_clock = {
      align   = "center",
      valign  = "center",
      refresh = 0.5,
      format  = "%H:%M:%S",
      widget  = wibox.widget.textclock
    }
  local icon_path = const.ICONS_DIRECTORY .. "clock/clock.svg"
  return components.bar_container_with_icon(
    text_clock,
    "Grey900",
    "Yellow900",
    "Grey900",
    icon_path
  )
end


return clock
