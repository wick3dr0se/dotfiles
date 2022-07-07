#!/bin/bash

c() {
if [[ $1 ]] ; then
  local input="${1%.*}.c"
  [[ -f $input ]] && out 'File exist' 1 && return
  # pass some formatted text to first argument
cat >> $input <<C
#include <stdio.h>

int main() {

  return 0;
}
C
  vim $input
else
  out 'No file specified' 1
fi
}

compile() {
if [[ $1 ]] ; then

  input=()
  for i in $@ ; do
    input+=("${i%.*}.c")
  done

  output=${input%.*}

  [[ $2 ]] && flag='-lm'

  gcc $flag ${input[@]} -o $output && ./$output
else
  out 'No file specified' 1
fi
}
