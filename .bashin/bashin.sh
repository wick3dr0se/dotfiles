#!/bin/bash

set -a

_source() {
	[[ $0 == bashin.sh ]] || path="${BASH_SOURCE%/*}"

	for i in "$@" ; do
		i="/${i/.sh}.sh"

		[[ $1 ]] || i='./*'
		
    . "${path}${i}"
	done
}

_run() {
  [[ $path == . ]] && {
    path="${PWD##*/}"

    [[ -f ${HOME}/${path} ]] || path=".${path}"
  }

  "${HOME}/${path}/${1}" < <(echo "$input")
}

math() {
  input="$@"

  _run 'arithmetic'
}

_source 'ansi' 'strings'
