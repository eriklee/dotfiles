# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' prompt 'Errors: %e'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/erik/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=300000
bindkey -v
# End of lines configured by zsh-newuser-install
typeset -A key

# let bg jobs continue
setopt NO_HUP
# change dirs by typing the dir
setopt AUTO_CD

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

PROMPT="[%?]%n@%m:%~%# "

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#  This doesn't work with a window maximized...
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# this is to get tmux doing solarized correctly. I think.
# http://unix.stackexchange.com/questions/66579/how-do-i-get-the-solarized-colour-scheme-working-with-gnome-terminal-tmux-and-v
alias tmux='TERMINFO=/usr/share/terminfo/x/xterm-16color TERM=xterm-16color tmux -2'

alias todo='vim ~/todo'
alias notes='vim ~/notes'
alias working='vim ~/working'

# GAMBIT SPECIFIC
export PYTHONSTARTUP=~/.startup.py
export PYTHONPATH=$PYTHONPATH:/home/erik/code/gambitpy:/home/erik/code/scrape:/home/erik/code/lineproto:/home/erik/code/dumaclient:/home/erik/code/bacon:/home/erik/code/exchange:
export PYTHONPATH=$PYTHONPATH:`sh /home/erik/.pypath`:
export PATH=/home/erik/.cabal/bin:/home/erik/code/bin:/home/erik/.local/bin/:/home/erik/scripts/:$PATH
export PYTHONWARNINGS=default

alias scrapefox='firefox -new-instance -P scrapers'
alias sclogs='ssh erik@sclogs'
alias runscraper='rlwrap python alive.py '
alias anna='python /home/erik/code/anna/anna.py'
alias livecode='ssh -A erik@bart'
alias rugby='ssh histweb'
alias bigbrother='python /home/erik/code/bigbrother/bigbrother.py'

alias dialyze='redo dialyzer 2>&1 | less'

export DUMA_DSN='host=localhost user=erik dbname=testduma'
source '/home/erik/code/duma/init_erl_libs.sh'

alias dumerl='rlwrap erl -sname 'shell' -s duma start duma'
