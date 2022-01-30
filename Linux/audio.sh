#!/bin/bash

# Make volume control saner / work better for me.

_help="
    Options:
    - up / down: change volume by 2% in either direction
    - mute: toggle mute of PC speakers
"

if [[ $1 == "--help" ]]
then
    echo "$_help"
fi

# Name of the PulseAudio sink to target.
# Find with `pactl list sinks short`
# This currently always targets the PC speakers:
sink=alsa_output.pci-0000_2d_00.4.analog-stereo

volumeStep=2

# If `all` argument is passed target the combined output sink.
if [[ $2 == "all" ]]
then
    sink=combined
fi

# If `tv` argument is passed target the tv sink.
if [[ $2 == "tv" ]]
then
    sink=alsa_output.pci-0000_2b_00.1.hdmi-stereo-extra3
    volumeStep=10
fi

# Location of the `i3-volume` application.
i3volume=$HOME/Applications/i3-volume/volume

changeVolume() {
    volume=$(getVolume)
    # Don't go past 100% volume.
    if [[ $volume == 100 && "$1" == "up" ]]
    then
        return
    fi
    # Set the volume +/- 2%
    $i3volume -s $sink "$1" $volumeStep
}

getVolume() {
    # Get the volume as a percent (eg 60%).
    local volumePercent
    volumePercent=$($i3volume -s $sink output %v)
    # Get the volume without the percent sign.
    local volume
    volume=$(echo "$volumePercent" | cut -d'%' -f 1)
    echo "$volume"
}

notify() {
    local volume
    volume=$(getVolume)
    # Send generic notification (works with GNOME) that the volume has changed to trigger notification. TODO: A way to trigger OSD on GNOME would be much nicer.
#     notify-send "Toggled mute for PC Speakers" "Volume: $volume"
    # Send notification to Plasma that the volume has changed to trigger OSD.
    qdbus-qt5 org.kde.plasmashell /org/kde/osdService volumeChanged $volume
    # Alternate notification option:
    # kdialog --title "Pulseaudio" --passivepopup "Toggled PC Speaker Mute" 1 &
}

toggleMute() {
    pactl set-sink-mute $sink toggle
}

if [[ $1 == "up" ]] || [[ $1 == "down" ]]
then
    changeVolume "$1"
    notify

elif [[ $1 == "mute" ]]
then
    toggleMute
    notify
fi

# Play feedback blip sound.
# paplay --device=$sink $HOME/Nextcloud/Scripts/Linux/volume.ogg
