alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias diff='diff --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias mkdir='mkdir -pv'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias free='free -h'
alias df='df -h'
alias du='du -h --max-depth=1'
alias tcpu='top -o %CPU'
alias tmem='top -o %MEM'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias c='clear'
alias q='exit'
alias h='history'

alias ip='ip -c'
alias ports='ss -tulnp'
alias ping='ping -c 3'

alias reload='source ~/.bashrc'
alias path='echo -e ${PATH//:/\\n}'

alias icat='kitten icat'
alias lskernel='vkpurge list'
alias clrkernel='doas vkpurge rm all'

alias minifetch='~/.config/scripts/mini_fetch.sh'
alias nvidia-on='doas ~/.config/scripts/nvidia_toggle.sh -e'
alias nvidia-off='doas ~/.config/scripts/nvidia_toggle.sh -d'
