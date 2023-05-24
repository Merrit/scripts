#!/bin/bash

set -x


# Find the window class name with `wmctrl -lx`, or with `xprop`, then use xdotool to get the window geometry
# xdotool search --onlyvisible --class TelegramDesktop getwindowgeometry
# or
# sleep 2 && xdotool getactivewindow getwindowgeometry


# -------------------------- Previous implementation ------------------------- #
# xdotool search --onlyvisible --class adventure_list windowsize --sync 2092 1338 windowmove --sync 5056 1140
# xdotool search --onlyvisible --class desktop_clock windowsize --sync 628 302 windowmove --sync 5108 356
# xdotool search --onlyvisible --class discord windowsize --sync 2313 1762 windowmove --sync 6655 748
# xdotool search --onlyvisible --class spotify windowsize --sync 2432 1757 windowmove --sync 5128 769
# xdotool search --onlyvisible --class TelegramDesktop windowsize --sync 2065 1863 windowmove --sync 5081 597
# -------------------------- /Previous implementation ------------------------ #


# Move and resize windows with wmctrl
#
# -r <WIN>
#   Specify a target window for an action.
#
# -x
#   Interpret the <WIN> argument for the -r action as a string to be matched against the WM_CLASS
#   rather than a numerical window id.
#
# The five options are: “gravity,X,Y,width,height”.

wmctrl -x -r "adventure_list" -e 1,5100,1100,2092,1338
wmctrl -x -r "desktop_clock" -e 1,5108,356,628,302 -b add,sticky

# Discord
window_ids=$(wmctrl -lx | grep "discord" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,6655,748,2313,1762
done

# Firefox
window_ids=$(wmctrl -lx | grep "Navigator.firefox" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,911,352,3286,2084
    wmctrl -i -r $window_id -b add,maximized_vert,maximized_horz
done

# GNOME Software
window_ids=$(wmctrl -lx | grep "org.gnome.Software.org.gnome.Software" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,1185,308,2738,2184
    wmctrl -i -r $window_id -b add,sticky
done

# Google Calendar
window_ids=$(wmctrl -lx | grep "crx_kjbdgfilnfhdoflbpgamdcdgpehopbep" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,802,181,3504,2426
done

# Google Keep (all windows)
window_ids=$(wmctrl -lx | grep "crx_eilembjdkfgodjkcjnpgpaenohkicgjd" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,917,364,3274,2060
done

wmctrl -x -r "lutris" -e 1,1206,354,2696,2080

# Nautilus (all windows)
window_ids=$(wmctrl -lx | grep "org.gnome.Nautilus" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,1351,444,2406,1912
done

wmctrl -x -r "spotify" -e 1,5128,769,2432,1757 -b add,sticky

# Telegram
window_ids=$(wmctrl -lx | grep "TelegramDesktop" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,5084,656,2064,1790
done

# Visual Studio Code Insiders (all windows)
window_ids=$(wmctrl -lx | grep "code - insiders" | cut -d' ' -f1)
for window_id in $window_ids; do
    wmctrl -i -r $window_id -e 1,850,197,3408,2382
done
