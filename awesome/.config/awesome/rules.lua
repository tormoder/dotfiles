-- {{{ Rules

local awful 	= require("awful")
local beautiful = require("beautiful")

awful.rules.rules = {
    
	-- All clients will match this rule.
    	{ rule = { },
      	properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
		     size_hints_honor = false,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },

	{ rule = { class = "Firefox",  name = "Downloads" },
	 properties = { floating = true } },

	{ rule = { class = "Firefox",  name = "Firefox Preferences" },
	 properties = { floating = true } },

	{ rule = { class = "Xmessage", instance = "xmessage" },
      	properties = { floating = true }, callback = awful.titlebar.add  },

    	{ rule = { instance = "plugin-container" },
      	properties = { floating = true } },
    	
	{ rule = { class = "Exe" },
      	properties = { floating = true } },

	{ rule = { class = "MPlayer" },
      	properties = { floating = true } },

	{ rule = { class = "Vlc" },
      	properties = { floating = true } },

	{ rule = { class = "Spotify" },
	properties = { floating = false} },

}
-- }}}
