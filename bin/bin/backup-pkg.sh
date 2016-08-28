#!/bin/sh
pacman -Qqe | grep -vx "$(pacman -Qqm)" > $HOME/disk2/d/backup/mba-arch/pkg.list
