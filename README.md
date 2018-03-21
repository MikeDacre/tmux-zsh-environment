# Tmux ZSH Environment

Share environmental variables more seamlessly between tmux and ZSH.

Tmux includes an `update-environment` command that means that any new shells
recieve the variables in `update-environment` when they are loaded. However,
existing shells do not recieve these variables, meaning that things like
`DISPLAY` become out-of-date when sshing into a machine and connecting to an
existing session.

This ZSH plugin adds a lightweight `precmd` function that hooks into ZSH,
runs on every new prompt, and updates the current shell environement with any
variables loaded in the tmux `show-environment` array (this includes only those
variables that were both set by `update-environment` and set in the calling
environment).

By default, tmux updates the following variables:

```shell
DISPLAY SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION WINDOWID
XAUTHORITY
```

If these look good to you, this plugin will work out of the box to keep those
updated, if not, you can just add the following line to your `~/.tmux.conf`:

```shell
set -g update-environment "DISPLAY SSH_CONNECTION XAUTHORIT"
```

# Installation

## [Antigen](github.com/zsh-users/antigen)

If you're using [Antigen](github.com/zsh-users/antigen), just add `antigen
bundle MikeDacre/tmux-zsh-environment` to your `.zshrc` file where you're
loading your other zsh plugins.

## [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)

1. `mkdir -p ~/oh-my-zsh/custom/plugins`
2. `cd ~/oh-my-zsh/custom/plugins`
3. `git clone git@github.com:MikeDacre/tmux-zsh-environment`
4. `echo "plugins+=(tmux-zsh-environment)" >> ~/.zshrc`

## [Zgen](tarjoilija/zgen)

If you're using [Zgen](tarjoilija/zgen), add `zgen load MikeDacre/cdbk` to your
`.zshrc` file where you're loading your other zsh plugins.
