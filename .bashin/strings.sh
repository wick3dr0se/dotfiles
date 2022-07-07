#!/bin/bash

regex() {
  local i

  for i in $1 ; do
    [[ $i =~ $2 ]] && echo $BASH_REMATCH
  done
}

truncate() {
  local i string

  for i in $1 ; do
    string+=" $i"
  done
  echo ${string# }
}

trim() {
  : "$1"
  printf '%s\n' "${_[@]/$2}"
}

trim_all() {
  : "$1"
  printf '%s\n' "${_[@]//$2}"
}

split() {
  local i string

  IFS="$2" 
  for i in $1 ; do
    string+=$i
  done
  truncate $string
}

head() {
  mapfile -tn "$1" row < "$2"
  printf '%s\n' "${row[@]}"
}

tail() {
  mapfile -tn 0 row < "$2"
  printf '%s\n' "${row[@]: -$1}"
}

rows() {
  mapfile -tn 0 rows < "$1"
  printf '%s\n' "${#rows[@]}"
}

random_element() {
	local var=($@)
	
  echo "${var[RANDOM%${#var[@]}]}"
}

unique_element() {
	local col var1 var2

	for col in ${arr1[@]} ; do
		var1+="^${col}$"
	done

	for col in ${arr2[@]} ; do
		var2+="^${col}$"
	done

	for col in ${arr1[@]} ${arr2[@]} ; do
		[[ $var1 =~ "^${col}$" ]] || printf '%s ' "$col"
		[[ $var2 =~ "^${col}$" ]] || printf '%s ' "$col"
	done
	echo
}
