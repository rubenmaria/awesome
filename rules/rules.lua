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
      screen = screenInfo.primary,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false,
      titlebars_enabled = true,
      maximized = false,
      opacity = 1,
      floating = false
    }
  }
end

local function floating_clients()
  return {
    rule_any = {
      instance = {},
      class = {
        "explorer.exe",
        "leagueclientux.exe",
        "leagueclient.exe",
      },
      name = {},
    },
    properties = { floating = true },
  }
end

local function firefox()
  return {
    rule_any = {
      instance = {},
      class = {
        "firefox",
      },
      name = {},
    },
    properties = {
      maximized = false,
      opacity = 1,
      floating = false,
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal
    }
  }

end

function rules.init_client_rules()
  awful.rules.rules = {
    all_clients(),
    floating_clients(),
    firefox(),
  }
end

return rules
