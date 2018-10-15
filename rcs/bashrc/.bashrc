#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\] \[\e[32m\]@\[\e[m\] \[\e[33m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[34m\]\w\[\e[m\] \[\e[36m\]\\$\[\e[m\] "

alias "pacman"="sudo pacman"
alias "p"="sudo pacman -S --noconfirm"
alias "u"="sudo pacman -Syu --noconfirm"
alias "w"="sudo wifi-menu"
alias "wifi-menu"="sudo wifi-menu"
alias "spotify"="spotify ; blockify"
alias "rambox"="cd ~/.apps/rambox && npm start &"
