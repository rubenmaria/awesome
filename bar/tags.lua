local awful    = require("awful")
local keybinds = require("keybinds")
local wibox    = require("wibox")
local gears    = require("gears")

local tags = {}
local s = "𝜶𝜷𝜸𝜹𝜺𝜻𝜼𝜽𝜾𝜿𝝀𝝅𝝍 "
local spacing_size = 5
local seperator_color = "#FC810C"
function tags.construct_taglist_on_screen(screen)
  awful.tag(
    { " ", " ", " ", " ", " ", " ", " ", " " },
    screen,
    awful.layout.layouts[3]
  )

  screen.mytaglist = awful.widget.taglist {
    screen  = screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = keybinds.taglist_buttons,
    style   = gears.rounded_rect,
    layout  = {
      spacing = spacing_size,
      spacing_widget = {
          color  = seperator_color,
          shape  = gears.rounded_rect,
          widget = wibox.widget.separator,
      },
      layout  = wibox.layout.fixed.horizontal
      },
  }
end

return tags
