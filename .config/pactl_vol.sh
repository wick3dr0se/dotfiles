#!/bin/bash

sink=$(pactl get-default-sink)

left=$(pactl get-sink-volume $sink | awk '/front-left/{print $5}')
right=$(pactl get-sink-volume $sink | awk '/front-right/{print $12}')

[[ $left != $right ]] && {
  read -p 'Speakers out of sink. Would you like to auto-balance? [y/n] '
  [[ ${REPLY,,} == [y] || ${REPLY,,} == yes ]] && 
    pactl set-sink-volume $sink 0%
    echo 'Balancing sucessful'
}

if [[ $1 == mute ]] ; then
  pactl set-sink-mute $sink toggle
else
  operator=${1/[0-9]*}
  per="${1##$operator}"
  operand=${per%%%}

  [[ ! $operator && $operand == 0 ]] && pactl set-sink-volume $sink 0%
  
  pactl set-sink-volume ${sink:-$(echo 'No default sink set')} "${operator:-+}${operand:-10}%"
fi
