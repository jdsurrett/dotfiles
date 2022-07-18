#!/usr/bin/env zsh

pamac () {
    tput clear
    /usr/bin/pamac $@ | lolcat -i -p 9.0
}
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
# alias tree="lsd --tree --date='+ ║ %D ┊ %I:%M %p ║' --group-dirs=last --blocks=date --blocks=name --blocks=size"
alias cargo="cargo"
alias vim="lvim"
alias vi="lvim"
alias v="lvim"
alias nvimtutor="lvim -c :Tutor"
alias vimtutor="lvim -c :Tutor"
alias vitutor="lvim -c :Tutor"
alias vtutor="lvim -c :Tutor"
alias ls="lsd"
alias la="lsd -l --almost-all"
alias tree="lsd -l --almost-all --tree"
alias ll="lsd -l"
alias xs="sl -l"
alias vf="sl -f"
alias cl="sl -Fla"
alias holly="sl -Fla"
alias vl="sl -Fla"
alias tclear="tput clear"
