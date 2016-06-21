#!/bin/sh
pacman -Qqe | grep -vx "$(pacman -Qqm)" > $HOME/disk2/Backup/mba-arch/pkg.list
