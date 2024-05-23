# Enable autocompletion.
autoload -Uz compinit
compinit

setopt histignorealldups sharehistory

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Commonly used aliases.
alias l="ls"
alias ls="ls --color=auto"
alias ll="ls -la"
alias lh="ls -lha"

alias vi="nvim"

alias gitd="git diff"
alias gits="git status"

# Load the rustup toolchain environment.
. "$HOME/.cargo/env"

# Enable the starship.rs prompt.
eval "$(starship init zsh)"
