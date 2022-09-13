#!/bin/bash

# Send the window under the mouse cursor to the other virtual desktop.

desktopIndex=$(xdotool get_desktop)

targetDesktopIndex
if [[ $desktopIndex == 0 ]]
then
    targetDesktopIndex=1
else
    targetDesktopIndex=0
fi

windowId=$(xdotool getmouselocation --shell | grep WINDOW | awk -F "=" '{print $2}')

xdotool set_desktop_for_window "$windowId" $targetDesktopIndex
xdotool set_desktop $targetDesktopIndex
