#!/bin/zsh
#######################################################################
#                    Tmux ZSH Environment Sharing                     #
#######################################################################

# Update shell environment from variables
_tmux_zsh_env__precmd() {
    local envs
    local old_ifs
    # Split on newline only
    old_ifs=${IFS}
    # Get only set variables from tmux
    IFS=$'\n' envs=($(tmux show-environment | grep -v "^-" | grep '=' | sed 's/ /\\ /g'))
    IFS=${old_ifs}
    # Evaluate
    for env in "${envs[@]}"; do
        eval "${env}"
    done
}

# Add the function as a precmd, so it runs on every prompt update
# Only do this if no one has set TMUX_ENV_AUTOUPDATE_DONE, this allows
# other plugins to specify this without worrying about duplicate work.
if [ -z "$TMUX_ENV_AUTOUPDATE_DONE" ]; then
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _zsh_title__precmd
fi
