#!/bin/bash

sink=$(pactl list sinks short | awk /RUNNING/'{print $1}')

if [[ $1 == up ]] ; then
  direction=+
elif [[ $1 == down ]] ; then
  direction=-
elif [[ $1 == mute ]] ; then
  pactl set-sink-mute $sink toggle && exit
fi

[[ $2 ]] && N=$2 || N=$1

pactl set-sink-volume $sink ${direction:-+}${N:-10}%
