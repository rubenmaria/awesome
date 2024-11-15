local gears = require("gears")
local constants = {}

constants.CONFIG_DIRECTORY = gears.filesystem.get_configuration_dir()
constants.ASSETS_DIRECTORY = constants.CONFIG_DIRECTORY .. "assets/"
constants.ICONS_DIRECTORY = constants.ASSETS_DIRECTORY .. "icons/"
constants.WALLPAPER_DIRECTORY = constants.ASSETS_DIRECTORY .. "wallpaper/"
constants.SCRIPTS_DIRECTORY = constants.CONFIG_DIRECTORY .. "scripts/"
constants.THEME_DIRECTORY = constants.CONFIG_DIRECTORY .. "themes/"

return constants
