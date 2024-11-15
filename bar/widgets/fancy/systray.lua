local gears  = require("gears")
local wibox  = require("wibox")
local colors = require("themes.colors")
local dpi    = require("beautiful").xresources.apply_dpi
local systray = {}

local function connect_signals(systray_widget)
  awesome.connect_signal("systray::update", function()
    local num_entries = awesome.systray()
    if num_entries == 0 then
      systray_widget.container.st:set_margins(0)
    else
      systray_widget.container.st:set_margins(dpi(6))
    end
  end)
  systray_widget.container.st.widget:set_base_size(dpi(20))
end


systray.new_systray = function()
  local systray_widget = wibox.widget {
    {
      {
        wibox.widget.systray(),
        widget = wibox.container.margin,
        id = "st"
      },
      strategy = "exact",
      layout = wibox.container.constraint,
      id = "container"
    },
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    bg = colors["BlueGrey800"]
  }
  connect_signals(systray_widget)
  return systray_widget
end


return systray
