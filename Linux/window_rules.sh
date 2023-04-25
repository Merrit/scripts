#!/bin/bash


# Find the window class name with xprop, then get the window info like size, etc
# xdotool search --onlyvisible --class TelegramDesktop getwindowgeometry

xdotool search --onlyvisible --class adventure_list windowsize --sync 2092 1338 windowmove --sync 5056 1140
xdotool search --onlyvisible --class desktop_clock windowsize --sync 628 302 windowmove --sync 5108 356
xdotool search --onlyvisible --class discord windowsize --sync 2313 1762 windowmove --sync 6655 748
xdotool search --onlyvisible --class spotify windowsize --sync 2432 1757 windowmove --sync 5128 769
xdotool search --onlyvisible --class TelegramDesktop windowsize --sync 2065 1863 windowmove --sync 5081 597
