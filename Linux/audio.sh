#!/bin/bash

# Make volume control saner / work better for me.




# ---------------------------------------------------------------------------- #
#                            USE DART SCRIPT INSTEAD                           #
# ---------------------------------------------------------------------------- #




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
# Defaults to the PC speakers.
sink=alsa_output.pci-0000_2d_00.4.analog-stereo

volumeStep=2

# If `all` argument is passed target the combined output sink.
if [[ $2 == "all" ]]
then
    sink=combined
fi

targetingTV=false

# If `tv` argument is passed target the tv sink.
if [[ $2 == "tv" ]]
then
    sink=alsa_output.pci-0000_2b_00.1.hdmi-stereo-extra3
    volumeStep=10
    targetingTV=true
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

_notificationsId="audio-script"

notify() {
    local volume
    volume=$(getVolume)
    volumeDouble=$(bc <<< "scale=2; $volume/100")

    local icon

    if [[ $volume != "MUTE" ]]
    then
        volume="$volume%"
        icon="audio-volume-medium"
    else
        icon="audio-volume-muted"
    fi

    # Disable this check for now, because the DBus version works much better.
    # Keeping it around because I believe the next version of GNOME has
    # dropped this DBus method and we will need an alternative..
    # Don't forget that creating an OSD via Flutter is an option!
    # if [ $targetingTV = true ] ; then
    local target

    if [[ $targetingTV = true ]]
    then
        target='TV'
    else
        target='Speakers'
    fi

    if true ; then
        # Trigger GNOME's OSD via DBUS.
        gdbus call --session --dest 'org.gnome.Shell' \
        --object-path '/org/gnome/Shell' \
        --method 'org.gnome.Shell.ShowOSD' "{'icon': <'$icon'>, \
        'label': <'$target volume: $volume'>, 'level': <$volumeDouble>}"
    else
        # Send generic notification (works with GNOME) that the volume has changed to trigger notification.
        _notificationsId=$(/home/merritt/.local/bin/notify-send.py \
            "Volume" "$volume" \
            --hint string:image-path:$icon \
            boolean:transient:true \
            --replaces-process $_notificationsId)
    fi

    # Send notification to Plasma that the volume has changed to trigger OSD.
    # qdbus-qt5 org.kde.plasmashell /org/kde/osdService volumeChanged $volume
    # Alternate notification option:
    # kdialog --title "Pulseaudio" --passivepopup "Toggled PC Speaker Mute" 1 &
}

toggleMute() {
    pactl set-sink-mute $sink toggle
    notify
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
