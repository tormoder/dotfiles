#!/bin/sh
pacman -Qqe | grep -vx "$(pacman -Qqm)" > /storage/disk2/d/backup/workstation/pkg.list
