#!/bin/bash

i3volume=$HOME/Applications/i3-volume/volume

sink="alsa_output.pci-0000_2d_00.4.analog-stereo"

pactl set-sink-mute $sink toggle

# kdialog --title "Pulseaudio" --passivepopup "Toggled PC Speaker Mute" 1 &

$i3volume -s alsa_output.pci-0000_2d_00.4.analog-stereo output %i %v

notify-send "Toggled PC Speaker Mute"
