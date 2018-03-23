#!/bin/zsh
#######################################################################
#                    Tmux ZSH Environment Sharing                     #
#######################################################################

# Do nothing at all if we are not in tmux, second test is needed in
# case of an ssh session being run from within tmux, which could result
# in $TMUX from the parent session being set without tmux being
# connected.
if [ -n "$TMUX" ] && tmux ls >/dev/null 2>/dev/null; then
    # Update shell environment from variables
    _tmux_zsh_env__precmd() {
        eval "${tmux show-environment -s}"
    }

    # Add the function as a precmd, to be run at every new prompt
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _zsh_title__precmd
fi
