# ~/.bashrc

# if not running interactively, end
[[ $- != *i* ]] && return

alias b='bash'
alias brc='. ~/.bashrc'
alias v='vim'
alias bedit='vim ~/.bashrc'
alias vedit='vim ~/.SpaceVim.d/init.toml'
alias cedit='vim ~/.c.sh'
alias key='cat ~/git/.key'
alias del='rm -fr'
alias startx='startx /usr/bin/i3'

scripts='~/git/scripts'
alias bg="b $scripts/bg.sh"
alias colors="b $scripts/colors.sh"
alias dir="b $scripts/dir.sh"
alias d='dir'
alias keygen="b $scripts/keygen.sh"
alias nill="b $scripts/nill.sh"
alias temps="b $scripts/temps.sh"

alias add='yay -S'
alias look='yay -Ss --color=auto'
alias rmv='yay -Runss'

out() {
declare -A msg
local msg
  
msg[1]=ERROR
msg[2]=SUCCESS
printf '[\e[1;3%sm%s\e[0m]: %s\n' \
  "$2" "${msg[$2]}" "$1"
}

_source() {
  for i in "$@" ; do
    . "${i}.sh"
  done
}

_source '.c' '.bashin/bashin'

# prompt
shopt -s autocd cdspell dirspell cdable_vars

prompt_command() {
  dir='~'
  [[ $PWD == $HOME ]] || dir="${PWD/$HOME\/}"
  branch=$(git branch 2>/dev/null)
  tag=$(git tag 2>/dev/null)

	[[ $EUID -eq 0 ]] && symbol='#' || symbol='$'
  
  timeStart=$(date +%s)

	sec=$(((timeStart-timeEnd)%60))
	min=$(((timeStart-timeEnd)%3600/60))
	hr=$(((timeStart-timeEnd)/3600))

	timer=
  (( $hr > 0 )) && timer=$(printf '\e[31m%s\e[0mh, ' "$hr")
  (( $min > 0 )) && timer+=$(printf '\e[33m%s\e[0mm, ' "$min")
  (( $sec > 0 )) && timer+=$(printf '\e[32m%s\e[0ms ' "$sec")
  
  [[ $timer ]] && timer="in $timer"

  timeEnd=$timeStart

  printf '%s \e[36m%s \e[0m%s %s\n' \
    "$dir" "${branch#* }" "$tag" "$timer"
}

PROMPT_COMMAND=prompt_command
timeEnd=$(date +%s)

PS1="\$([[ \$? -eq 0 ]] && printf '\[\e[32m\]%s\[\e[m\] ' "\$symbol" || \
  printf '\[\e[31m\]%s\[\e[0m\] ' "\$symbol")"

PS4='-[\e[33m${BASH_SOURCE/.sh}\e[0m: \e[32m${LINENO}\e[0m] '
PS4+='${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
