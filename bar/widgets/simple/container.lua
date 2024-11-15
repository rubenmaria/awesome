local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local container = {}

function container.new_container(widget, fg_color, bg_color)
	return wibox.widget({
		{
			{
				{
					widget = widget,
				},
				left = dpi(5),
				right = dpi(4),
				top = 0,
				bottom = 0,
				widget = wibox.container.margin,
			},
			shape = gears.shape.rounded_bar,
			fg = fg_color,
			bg = bg_color,
			widget = wibox.container.background,
		},
		spacing = dpi(2),
		layout = wibox.layout.fixed.horizontal,
	})
end

return container
