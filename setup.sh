#!/bin/bash

out() {
  sgr='Succes'
  [[ $2 == 1 ]] && sgr='Error'
  
  printf '[\e[1;3%sm%s\e[0m]: %s\n' "$2" "$sgr" "$1"
}

is_yes() {
  local input=${REPLY,,}

  [[ $input == [y] || $input == yes ]]
}

[[ -d ~/.config ]] || mkdir ~/.config/

for i in kitty/ picom/ rofi/ dunst/ ; do
  [[ ! -d ~/.config/$i ]] && {
    cp -r $i ~/.config/
    pass=0
  } || {
    read -p "$i exist. Do you want to overwrite?"
    
    is_yes && cp -r $i ~/.config/ ||
      out "Failed to setup $i" 1
  }
done
[[ $pass ]] && out 'Dotfile configurations set' 2


read -p 'Install yay {A pacman & AUR package manager)? [y/n]: ' yay

read -p 'Install packages list? [y/n]: '

is_yes && {
  [[ $yay ]] && {
    yay -S - < packages
    out 'Installed packages with yay' 2
  } || {
    pacman -S - < packages
    out 'Installed packages with pacman' 2
  }
} || out 'Package installation aborted' 1


read -p 'Setup the BASH prompt & framework? [y/n]: '

is_yes && {
  cp -r .bashin/ .bashrc .c.sh ~/
  out 'Prompt successfully set!' 2
} || out 'Aborting prompt & framework setup' 1 && exit
