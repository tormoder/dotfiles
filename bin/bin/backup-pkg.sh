#!/bin/sh
pacman -Qqe | grep -vx "$(pacman -Qqm)" > /storage/disk2/Backup/workstation/pkg.list
