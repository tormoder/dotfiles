local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")

-- reusable separator
separator = wibox.widget.textbox()
separator:set_text(" ")

-- reusable separator L
separator_l = wibox.widget.textbox()
separator_l:set_text(" [ ")

-- reusable separator R
separator_r = wibox.widget.textbox()
separator_r:set_text(" ] ")

-- cpu
cputext = wibox.widget.textbox()
cputext:set_text("cpu: ")

tzswidget = wibox.widget.textbox()
vicious.register(tzswidget, vicious.widgets.thermal, " $1°C", 20, { "thermal_zone2", "sys"} )

--- volume info
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)

volbar = wibox.widget {
	forced_height		= 10,
	forced_width 		= 20,
	color			= beautiful.fg_volbar,
	background_color 	= beautiful.bg_widget,
	widget                  = wibox.widget.progressbar,
}

vicious.register(volbar, vicious.widgets.volume,function (widgets, args)
	if args[1] == 0 or args[2] == "♩" then
		volicon:set_image(beautiful.widget_mute)
		return args[1]
	else
		volicon:set_image(beautiful.widget_vol)
		return args[1]
	end
end,  2, "Master")

volbarr = wibox.container.rotate(volbar, "east")

-- textclock widget
mytextclock = wibox.widget.textclock()
