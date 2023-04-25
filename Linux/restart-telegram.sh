#!/bin/bash

# Expand variables and echo all commands
set -x

# Restart Telegram
killall Telegram
sleep 1
/home/merritt/Applications/Telegram/Telegram -workdir /home/merritt/.local/share/TelegramDesktop/ -- %u &
# ~/Applications/Telegram/Telegram

# Minimize Telegram
sleep 4
xdotool search --onlyvisible --class Telegram windowminimize

exit
