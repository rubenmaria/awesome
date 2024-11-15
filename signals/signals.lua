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

--- Takes a wibox.container.background and connects four signals to it
---@param widget widget.container.background
---@param bg string
---@param fg string
function signals.hover_signal(widget, bg, fg)
  local old_wibox, old_cursor, old_bg, old_fg

  local mouse_enter = function()
    if bg then
      old_bg = widget.bg
      if string.len(bg) == 7 then
        widget.bg = bg .. 'dd'
      else
        widget.bg = bg
      end
    end
    if fg then
      old_fg = widget.fg
      widget.fg = fg
    end
    local w = mouse.current_wibox
    if w then
      old_cursor, old_wibox = w.cursor, w
      w.cursor = "hand1"
    end
  end

  local button_press = function()
    if bg then
      if bg then
        if string.len(bg) == 7 then
          widget.bg = bg .. 'bb'
        else
          widget.bg = bg
        end
      end
    end
    if fg then
      widget.fg = fg
    end
  end

  local button_release = function()
    if bg then
      if bg then
        if string.len(bg) == 7 then
          widget.bg = bg .. 'dd'
        else
          widget.bg = bg
        end
      end
    end
    if fg then
      widget.fg = fg
    end
  end

  local mouse_leave = function()
    if bg then
      widget.bg = old_bg
    end
    if fg then
      widget.fg = old_fg
    end
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end

  widget:disconnect_signal("mouse::enter", mouse_enter)

  widget:disconnect_signal("button::press", button_press)

  widget:disconnect_signal("button::release", button_release)

  widget:disconnect_signal("mouse::leave", mouse_leave)

  widget:connect_signal("mouse::enter", mouse_enter)

  widget:connect_signal("button::press", button_press)

  widget:connect_signal("button::release", button_release)

  widget:connect_signal("mouse::leave", mouse_leave)

end

return signals
