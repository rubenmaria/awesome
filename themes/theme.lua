--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi
local theme = {}




-- ===================================================================
-- Theme Variables
-- ===================================================================
local wallpaper_path = gears.filesystem.get_configuration_dir() .. "themes/wallpaper/"
local main_color = "#FC810C"

theme.name = "pastel"

-- Font
theme.font          = "FiraCode Nerd Font Mono 10.5"
theme.tasklist_font = "FiraCode Nerd Font Mono 9"

-- Background
theme.bg_normal = "#1f2430"
theme.bg_dark = "#000000"
theme.bg_focus = "#151821"
theme.bg_urgent = "#ff3f41"
theme.bg_minimize = "#444444"

theme.wallpaper = wallpaper_path .. "night.jpg"
-- Foreground
theme.fg_normal = main_color
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- Window Gap Distance
theme.useless_gap = 5

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width  = 4
theme.border_normal = "#E3D217"
theme.border_focus  = "#FC810C"
theme.border_marked = theme.fg_urgent

-- Taglist
theme.taglist_fg_focus = "#E3D217"
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_occupied = "#ffffff"
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_urgent = "#d83f41"
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_font = "JetbrainsMono Nerd Font 15"

-- Tasklist
theme.tasklist_font = theme.font
theme.tasklist_disable_task_name = true
theme.tasklist_plain_task_name = true

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(26)

-- Notification Sizing
theme.notification_max_width = dpi(350)

-- System Tray
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = dpi(5)

-- Titlebars
theme.titlebar_bg_normal = "#333333"
theme.titlebar_bg_focus  = "#2d2d2d"

return theme
