local beautiful = require("beautiful")
local awful = require("awful")
local signals = {}

local function new_client_startup_event()
  client.connect_signal("manage", function(c)
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end)
end


local function client_mouse_enter_event()
  client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
  end)
end

local function focus_client_event()
  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
end

local function unfocus_client_event()
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end

function signals.connect_signals()
  new_client_startup_event()
  client_mouse_enter_event()
  focus_client_event()
  unfocus_client_event()
end

return signals
