#!/bin/bash
#
# Move a window to a certain location.
#
# Examples:
#   move_window.sh 'search --onlyvisible --name SpeedCrunch' top-right
#   move_window.sh getactivewindow bottom-left

set -euo pipefail

what=${1?What window would you like to move?}
where=${2?Where would you like to move your window to?}

# Determine the screen resolution
res=$(cat /sys/class/graphics/fb0/virtual_size)
screen_width=${res%,*} 
screen_height=${res#*,} 

# Determine the window size
window_id=$(xdotool $what)
eval $(xdotool $what getwindowgeometry --shell)

# Calculate the target location
case "$where" in
    top-left)       pos="0 0";;
    top-right)      pos="$(($screen_width-$WIDTH)) 0";;
    bottom-left)    pos="0 $(($screen_height-$HEIGHT))";;
    bottom-right)   pos="$(($screen_width-$WIDTH)) $(($screen_height-$HEIGHT))";;
    center)         pos="$(($screen_width/2-$WIDTH/2)) $(($screen_height/2-$HEIGHT/2))";;
    *)              pos="$where"
esac

# Move the window
xdotool windowmove $window_id $pos
