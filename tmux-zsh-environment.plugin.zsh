#!/bin/zsh
#######################################################################
#                    Tmux ZSH Environment Sharing                     #
#######################################################################

# Don't run if @delphij's version is running
[[ -n "$ZSH_TMUX_AUTOREFRESH" ]] || ZSH_TMUX_AUTOREFRESH=false

if "$ZSH_TMUX_AUTOREFRESH"; then
    return
fi

# Control running with TMUX_ZSH_SYNC
[[ -n "$TMUX_ZSH_SYNC" ]] || TMUX_ZSH_SYNC=true

if ! "$TMUX_ZSH_SYNC"; then
    return
fi

# Do nothing at all if we are not in tmux, second test is needed in
# case of an ssh session being run from within tmux, which could result
# in $TMUX from the parent session being set without tmux being
# connected.
if [ -n "$TMUX" ] && tmux ls >/dev/null 2>/dev/null; then
    # Update shell environment from variables, don't unset
    _tmux_zsh_env__preexec() {
        eval "$(tmux show-environment -s | grep -v "^unset")"
    }

    # Add the function as a precmd, to be run at every new prompt
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _zsh_title__preexec
fi
