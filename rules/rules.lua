local awful      = require("awful")
local beautiful  = require("beautiful")
local keybinds   = require("keybinds")
local screenInfo = require("monitors")
local rules      = {}

local function all_clients()
  return {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keybinds.client_keys,
      buttons = keybinds.client_buttons,
      screen = screenInfo.left,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false,
      titlebars_enabled = true,
      floating = false
    }
  }
end

local function floating_clients()
  return {
    rule_any = {
      instance = {"firefox", "gpick"},
      class = {},
      name = {},
      properties = {
        titletitlebars_enabled = false,
        floating = true,
      },
    }
  }
end

function rules.init_client_rules()
  awful.rules.rules = {
    all_clients(),
    floating_clients(),
  }
end

return rules
