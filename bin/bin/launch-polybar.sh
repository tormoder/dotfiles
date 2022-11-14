#!/bin/sh

export DPI=$(xrdb -query | sed -nE 's/^Xft\.dpi:\s*//p')
export HEIGHT=$((20 * DPI / 96))

MONITORS=$(polybar --list-monitors | sed -nE 's/([^ ]+): .*/\1/p' | tr '\n' ' ')
PRIMARY=$(polybar --list-monitors | grep -F '(primary)' | sed -nE 's/([^ ]+): .*/\1/p')
NMONITORS=$(echo $MONITORS | wc -w)
PRIMARY=${PRIMARY:-${MONITORS%% *}}

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

case $NMONITORS in
    1)
        MONITOR=$PRIMARY polybar --reload alone &
        ;;
    *)
        MONITOR=$PRIMARY polybar --reload primary &
        for MONITOR in ${MONITORS}; do
            [ $MONITOR != $PRIMARY ] || continue
            MONITOR=$MONITOR polybar --reload secondary &
        done
        ;;
esac
