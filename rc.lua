pcall(require, "luarocks.loader")
require("awful.autofocus")

local startup = require("startup")
local rules   = require("rules")
local signals = require("signals")

startup.init()
rules.init_client_rules()
signals.connect_signals()
