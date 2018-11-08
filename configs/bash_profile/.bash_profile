#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# output of startx to /dev/null
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
