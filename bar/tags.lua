local awful    = require("awful")
local keybinds = require("keybinds")
local wibox    = require("wibox")
local gears    = require("gears")

local tags = {}
local s = "𝜶𝜷𝜸𝜹𝜺𝜻𝜼𝜽𝜾𝜿𝝀𝝅𝝍 "
local spacing_size = 5
function tags.construct_taglist_on_screen(screen)
  awful.tag(
    {"𝜶", "𝜷", "𝜸", "𝜹", "𝜺", "𝜻", "𝜼", "𝜽", "𝜾" },
    screen,
    awful.layout.layouts[3]
  )

  screen.mytaglist = awful.widget.taglist {
    screen  = screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = keybinds.taglist_buttons,
    style   = {
      gears.shape.rounded_rect,
    },
    layout  = {
      spacing = spacing_size,
      layout  = wibox.layout.fixed.horizontal
    }
  }
end

return tags
