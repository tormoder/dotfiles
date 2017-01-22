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

--- memory
memtext = wibox.widget.textbox()
memtext:set_text("mem: ")

membar = wibox.widget {
	ticks                   = true,
	ticks_size              = 2,
	forced_height           = 10,
	forced_width            = 20,
	background_color        = beautiful.bg_widget,
	color                   = beautiful.fg_membar,
	widget                  = wibox.widget.progressbar,
}
vicious.register(membar, vicious.widgets.mem, "$1", 13)
membarr = wibox.container.rotate(membar, "east")

--- eth0 & wlan0 up/down
ethtext = wibox.widget {
	text = " wlan: ",
	widget = wibox.widget.textbox,
}

ethwidget = wibox.widget.textbox()
vicious.register(
ethwidget, vicious.widgets.net, '<span color="'
.. beautiful.fg_netdn_widget ..'">${wlp2s0b1 down_kb}</span> <span color="'
.. beautiful.fg_netup_widget ..'">${wlp2s0b1 up_kb}</span>', 3
)

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

-- battery state
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_bat)

batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, "$1$2%", 61, "BAT0")

-- textclock widget
mytextclock = wibox.widget.textclock()
