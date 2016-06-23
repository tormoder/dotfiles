-- {{{ Menu

local beautiful = require("beautiful") 

-- Create a laucher widget and a main menu
myawesomemenu = {
{ "manual", terminal .. " -e man awesome" },
{ "edit config", editor_cmd .. " " .. awesome.conffile },
{ "restart", awesome.restart },
{ "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
			    { "firefox", "firefox" },
			    { "chromium", "chromium" },
			    { "thunar", "thunar" },
			    { "spotify", "spotify"},
			    { "terminal", terminal },
			    { "vim", vim},
			    { "reboot", "systemctl reboot" },
			    { "shutdown", "systemctl poweroff" }
			  }
		})


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
			     menu = mymainmenu })
-- }}}
