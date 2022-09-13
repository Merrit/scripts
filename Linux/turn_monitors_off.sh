#!/bin/bash

# Wayland
# xdg-screensaver activate

# gdbus call --session --dest org.gnome.Mutter.DisplayConfig --object-path /org/gnome/ScreenSaver --method org.gnome.ScreenSaver.SetActive true

# X11
# sleep 1 && xset dpms force off
sleep 1 && xscreensaver-command -activate

