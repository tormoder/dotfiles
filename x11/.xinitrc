#!/bin/sh

# Make sure this is before the 'exec' command or it won't be executed.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

if [ -f "$HOME/.Xresources" ]; then
	xrdb -merge $HOME/.Xresources
fi

# disable CapsLock & map to Escape
setxkbmap -option caps:swapescape

# set norwegian layout
setxkbmap -layout "no"

if ! pulseaudio --check; then
	pulseaudio --start
fi

/usr/bin/xscreensaver -no-splash &

xbindkeys

feh --bg-fill --randomize ~/.wallpapers/* &

exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
