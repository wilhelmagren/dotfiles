function fish_greeting
    # dont do anything
end


# man pages formatting
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

if test -f ~/.fish_profile
    source ~/.fish_profile
end

fish_add_path ~/.local/bin
fish_add_path ~/.local/share/coursier/bin

function history
    builtin history --show-time='%F %T ' $argv
end

function backup --argument filename
    cp $filename $filename.bak
end

alias ls='eza -al --color=always --group-directories-first --icons=always'
alias ll='eza -al --color=always --group-directories-first --icons=always'
alias l='eza --color=always --group-directories-first --icons=always'

alias tarnow='tar -acf '
alias untar='tar -xvzf '
alias hw='hwinfo --short'

# i use neovim btw
alias vi='nvim'
alias vim='nvim'

alias update='sudo cachyos-rate-mirrows && sudo pacman -Syu'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

source ~/.cargo/env.fish
source ~/.local/bin/env.fish

if status is-interactive
    set -gx COLORTERM truecolor
    set -g fish_term24bit 1

    zoxide init fish | source
    starship init fish | source
end
