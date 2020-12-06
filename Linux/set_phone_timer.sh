#!/bin/bash

# Send a message to AutoRemote / Tasker to set a timer

if [ $# -gt 0 ] # Check if there were CLI arguments
then
    # User enters time via CLI argument
    argumentTime=$(( $1 * 60 )) # Argument (minutes) translated into seconds
    time=$argumentTime
else
    # User enters time via GUI
    inputTime=$(zenity --entry --title "Set Timer" --text "Enter a new timer in minutes")
    inputTimeAsSeconds=$(( $inputTime * 60 )) # Input (minutes) translated into seconds
    time=$inputTimeAsSeconds
fi

curl http://192.168.1.104:1817/sendmessage?message=$time
