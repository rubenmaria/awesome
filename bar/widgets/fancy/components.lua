local wibox      = require("wibox")
local gears      = require("gears")
local color      = require("themes.colors")
local dpi        = require("beautiful").xresources.apply_dpi
local components = {}

function components.bar_container_with_icon(
  widget,
  fg_color,
  bg_color,
  icon_color,
  icon_path
  )
  return wibox.widget {
    {
      {
        {
          {
            {
              image  = gears.color.recolor_image(icon_path, color[icon_color]),
              widget = wibox.widget.imagebox,
              resize = true,
              id     = "icon"
            },
            widget = wibox.container.place,
            id     = "icon_layout"
          },
          widget = wibox.container.margin,
          top    = dpi(2),
          id     = "icon_margin"
        },
        widget,
        spacing = dpi(10),
        layout  = wibox.layout.fixed.horizontal,
        id      = "widget_layout",
      },
      widget = wibox.container.margin,
      left   = dpi(8),
      right  = dpi(8),
      id     = "container"
    },
    bg     = color[bg_color],
    fg     = color[fg_color],
    widget = wibox.container.background,
    shape  = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end
  }
end

return components
