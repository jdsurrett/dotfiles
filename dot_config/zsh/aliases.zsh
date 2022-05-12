#!/usr/bin/env zsh

pamac () {
    tput clear
    /usr/bin/pamac $@ | lolcat -i -p 9.0
}

tree () {
    tput clear
    lsd --tree --date='+ ║ %D ┊ %I:%M %p ║ ' --group-dirs=last --blocks=date --blocks=name --blocks=size
    }

alias cargo="tput clear && cargo"
alias vim="lvim"
alias vi="lvim"
alias v="lvim"
alias nvimtutor="lvim -c :Tutor"
alias vimtutor="lvim -c :Tutor"
alias vitutor="lvim -c :Tutor"
alias vtutor="lvim -c :Tutor"
alias ls="lsd"
alias la="tput clear && lsd -l --almost-all"
alias ll="tput clear && lsd -l"
alias xs="sl -l"
alias vf="sl -f"
alias cl="sl -Fla"
alias holly="sl -Fla"
alias vl="sl -Fla"
alias tclear="tput clear"
