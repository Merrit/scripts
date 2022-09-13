#!/bin/bash

# Expand variables and echo all commands
set -x

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <1>}]"
gsettings set org.gnome.desktop.interface scaling-factor 1
autorandr --load tv
xrandr --output DisplayPort-0 --scale 1x1
xrandr --output DisplayPort-1 --scale 1x1
xrandr --output HDMI-A-1 --scale 1x1
# xrandr --output DisplayPort-0 --off
# xrandr --output DisplayPort-1 --off
# xrandr --output HDMI-A-1 --scale 1x1 --primary

# while [[ "$#" -gt 0 ]]; do
#     case $1 in
#         -m|--move) target="$2"; shift ;;
#         -u|--uglify) uglify=1 ;;
#         *) echo "Unknown parameter passed: $1"; exit 1 ;;
#     esac
#     shift
# done

# echo "Where to deploy: $target"
# echo "Should uglify  : $uglify"

# shouldMove=false

# if [[ $1 == "move" ]]
# then
#     shouldMove=true
# fi

# Move wine virtual desktop to TV then toggle to fullscreen.
# sleep 5; xdotool getactivewindow windowmove --sync 5520 0
# ; wmctrl -r :ACTIVE: -b toggle,fullscreen
# sleep 5; wmctrl -r :ACTIVE: -b toggle,fullscreen

# Close Plex Media Player so the controller isn't affecting it while gaming.
# pkill plexmediaplayer
