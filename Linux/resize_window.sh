#!/bin/bash

# Resize the active window
# xdotool windowsize $id $width $height

id=`xdotool getactivewindow`

xdotool windowsize "$id" 1192 947
