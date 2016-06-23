-- Vicious widgets
local awful = require("awful")
awful.util = require("awful.util")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local vicious = require("vicious")

-- {{{ Reusable separator
separator = wibox.widget.textbox()
separator:set_text(" ")
-- }}}

-- {{{ Reusable separator L
separator_l = wibox.widget.textbox()
separator_l:set_text(" [ ")
-- }}}

-- {{{ Reusable separator R
separator_r = wibox.widget.textbox()
separator_r:set_text(" ] ")
-- }}}
--
-- {{{ CPU usage and temperature
cputext = wibox.widget.textbox()
cputext:set_text("cpu: ")
-- Initialize widgets
--cpugraph  = awful.widget.graph()
tzswidget = wibox.widget.textbox()
-- Graph properties
--cpugraph:set_width(40):set_height(14)
--cpugraph:set_background_color(beautiful.bg_widget)
--cpugraph:set_color(beautiful.fg_cpugraph)
--cpugraph:set_gradient_angle(0):set_gradient_colors({
--beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
--})
-- Register widgets
--vicious.register(cpugraph,  vicious.widgets.cpu,      "$1")
vicious.register(tzswidget, vicious.widgets.thermal, " $1°C", 20, { "thermal_zone2", "sys"} )
-- }}}

--- {{{ Memory usage
memtext = wibox.widget.textbox()
memtext:set_text("mem: ")

-- Initialize widget
membar = awful.widget.progressbar()
-- Pogressbar properties
membar:set_vertical(true):set_ticks(true)
membar:set_height(12):set_width(8):set_ticks_size(2)
membar:set_background_color(beautiful.bg_widget)
membar:set_color(beautiful.fg_membar)
--membar:set_gradient_colors({ beautiful.fg_widget,
--beautiful.fg_center_widget, beautiful.fg_end_widget
--})
-- Register widget
vicious.register(membar, vicious.widgets.mem, "$1", 13)
-- }}}

--- eth0 & wlan0 up/down
ethtext = wibox.widget.textbox()
ethtext:set_text(" eth0: ")
-- Initialize widget
ethwidget = wibox.widget.textbox()
-- Register widget
vicious.register(ethwidget, vicious.widgets.net, '<span color="'
    .. beautiful.fg_netdn_widget ..'">${eth0 down_kb}</span> <span color="'
    .. beautiful.fg_netup_widget ..'">${eth0 up_kb}</span>', 3)
-- }}}

--- volume info
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)

volbar = awful.widget.progressbar()
volbar:set_width(10)
volbar:set_height(18)
volbar:set_vertical(true)
volbar:set_background_color(beautiful.bg_widget)
volbar:set_color(beautiful.fg_volbar)
vicious.register(volbar, vicious.widgets.volume,function (widgets, args)
 			if args[1] == 0 or args[2] == "♩" then
 				volicon:set_image(beautiful.widget_mute)
 				return args[1]
 			else
 				volicon:set_image(beautiful.widget_vol)
 				return args[1]
 			end
		end,  2, "Master")

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({      screen = s,
        fg = beautiful.fg_normal, height = 16,
        bg = beautiful.bg_normal, position = "top",
        --border_color = beautiful.border_focus,
        --border_width = beautiful.border_width
    })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(separator)
    left_layout:add(mylayoutbox[s])
    left_layout:add(separator)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then
	right_layout:add(wibox.widget.systray())
	right_layout:add(separator)
    end
    right_layout:add(separator_l)
    right_layout:add(cputext)
    right_layout:add(tzswidget)
    right_layout:add(separator_r)
    right_layout:add(separator_l)
    right_layout:add(memtext)
    right_layout:add(membar)
    right_layout:add(separator_r)
    right_layout:add(separator_l)
    right_layout:add(ethtext)
    right_layout:add(ethwidget)
    right_layout:add(separator_r)
    right_layout:add(separator_l)
    right_layout:add(volicon)
    right_layout:add(volbar)
    right_layout:add(separator_r)
    right_layout:add(separator_l)
    right_layout:add(mytextclock)
    right_layout:add(separator_r)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}
