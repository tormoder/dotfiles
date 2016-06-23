local awful = require("awful")
local gears = require("gears")
awful.rules = require("awful.rules")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local vicious = require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
naughty.notify({ preset = naughty.config.presets.critical,
	     title = "Oops, there were errors during startup!",
	     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
local in_error = false
awesome.connect_signal("debug::error", function (err)
-- Make sure we don't go into an endless error loop
if in_error then return end
in_error = true

naughty.notify({ preset = naughty.config.presets.critical,
		 title = "Oops, an error happened!",
		 text = err })
in_error = false
end)
end
-- }}}

-- {{{ Variable definitions

config = awful.util.getdir("config")
beautiful.init("/home/tormod/.config/awesome/themes/mydustdark/theme.lua")
terminal = "konsole"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
exec   = awful.util.spawn
sexec  = awful.util.spawn_with_shell
altkey = "Mod1"
modkey = "Mod4"

layouts =
{
	awful.layout.suit.tile,			-- 1
	awful.layout.suit.tile.left,		-- 2
	awful.layout.suit.tile.bottom, 		-- 3
	awful.layout.suit.fair,			-- 4
	awful.layout.suit.max,			-- 5
	awful.layout.suit.magnifier,		-- 6
	awful.layout.suit.floating		-- 7
	--  awful.layout.suit.tile.bottom,
	--  awful.layout.suit.tile.top,
	--  awful.layout.suit.fair.horizontal,
	--  awful.layout.suit.spiral,
	--  awful.layout.suit.spiral.dwindle,
	--  awful.layout.suit.max.fullscreen,
}

-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.

tags = {
	names_s1 = { "1", "2", "3", "4", "5", "6", "7", "8" },
	names_s2 = { "1", "2", "3", "4", "5", "6", "7", "8" },
	layout_s1 = { layouts[1], layouts[1], layouts[7], layouts[7], layouts[7], layouts[7], layouts[7], layouts[7] },
	layout_s2 = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[7], layouts[7], layouts[7], layouts[7] }
}

tags[1] = awful.tag(tags.names_s1, 1, tags.layout_s1)
tags[2] = awful.tag(tags.names_s2, 2, tags.layout_s2)

-- }}}

--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients.  Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if #ctags == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

dofile(config .. "/menu.lua")
dofile(config .. "/widgetswibox.lua")
dofile(config .. "/bindings.lua")
dofile(config .. "/rules.lua")
dofile(config .. "/signals.lua")

function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end
