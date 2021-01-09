#!/bin/sh

# Takes one argument ($1) of either `up` or `down` for volume change direction.


# Name of the PulseAudio sink to target.
# Find with `pactl list sinks short`
sink=alsa_output.pci-0000_2d_00.4.analog-stereo

# Location of the `i3-volume` application.
i3volume=$HOME/Applications/i3-volume/volume


# Set the volume +/- 2%
$i3volume -s $sink $1 2

# Get the volume as a percent (eg 60%).
volumePercent=$($i3volume -s $sink output %v)

# Get the volume without the percent sign.
volume=$(echo $volumePercent | cut -d'%' -f 1)

# Send notification to Plasma that the volume has changed to trigger OSD.
qdbus org.kde.plasmashell /org/kde/osdService volumeChanged $volume

# Play feedback blip sound.
paplay --device=$sink $HOME/Nextcloud/Scripts/Linux/volume.ogg
