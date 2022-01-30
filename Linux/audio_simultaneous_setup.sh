#!/bin/bash

# PipeWire can do simultaneous audio output, however it loses configurations 
# on reboot. This script is to be run on boot to re-setup the configs.

# Create the simultaneous output sink.
pactl load-module module-null-sink media.class=Audio/Sink sink_name="Simultaneous Audio Output" channel_map=stereo

# Reconnect the real sinks to the new simultaneous sink.
~/Dropbox/Scripts/Linux/pw-loadwires pipewire-wirings

# Set the new simulataneous sink as the default / active.
pactl set-default-sink Simultaneous
