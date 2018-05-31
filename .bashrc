# Custom bash environment
bind '"\t":menu-complete'
bind '"\ep":history-search-backward'
set bell-style visible

# Custom prompt
export PROMPT_DIRTRIM=3
export PS1='\[\e[1m\]\h\[\e[0m\]_bash: \[\e[0;37m\]\w\[\e[0m\] > '

# Set colours to be always on
machine=$(echo $HOST $HOSTNAME | grep -c mac)
if [ $machine -ge 1 ]; then
    alias ls='ls -G'
    alias which='alias | gwhich --tty-only --read-alias --show-dot --show-tilde'
else
    alias ls='ls --color=auto'
    alias which='alias | which --tty-only --read-alias --show-dot --show-tilde'
fi
alias grep='grep --color=auto'

# Refresh env vars for smooth X11 forwarding in tmux
function refresh()
{
    if [ -z "$TMUX" ]; then
        echo -e '\e[1;32mrefresh:\e[0m FAILED - Not in a tmux session'
    else
        export $(tmux show-environment | grep "^DISPLAY")
        echo -e '\e[1;32mrefresh:\e[0m Updated DISPLAY variable'
    fi
}
