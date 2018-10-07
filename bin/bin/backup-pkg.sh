#!/bin/sh
pacman -Qqe | grep -vx "$(pacman -Qqm)" > /mnt/storage/d/backup/workstation/pkg.list
