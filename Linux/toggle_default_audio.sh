#!/bin/bash

# Toggle between active audio devices, notify user with kdialog.


# Get information on sinks:
# pactl list short sinks


tvSink="alsa_output.pci-0000_2b_00.1.hdmi-stereo-extra3"
pcSpeakersSink="alsa_output.pci-0000_2d_00.4.analog-stereo"

CURRENT_PROFILE=$(pactl list short sinks | grep RUNNING | awk '{print $2}')

if [ "$CURRENT_PROFILE" = "$pcSpeakersSink" ] ; then
        pactl set-default-sink "$tvSink"
        newSink="$tvSink"
        kdialog --title "Pulseaudio" --passivepopup "TV" 2 &
else
        pactl set-default-sink "$pcSpeakersSink"
        newSink="$pcSpeakersSink"
        kdialog --title "Pulseaudio" --passivepopup  "PC Speakers" 2 &
fi

pactl list short sink-inputs|while read stream; do
    streamId=$(echo $stream|cut '-d ' -f1)
    echo "moving stream $streamId"
    pactl move-sink-input "$streamId" "$newSink"
done
