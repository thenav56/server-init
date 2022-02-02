# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

plugins=(
    git vi-mode docker docker-compose tmux
)

source $ZSH/oh-my-zsh.sh

# User configuration

# History Configuration
HISTSIZE=10000000
SAVEHIST=10000000

setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

export EDITOR=vim
export VISUAL="vim"
export TERM=xterm

alias nvim=vim

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

_has fzf && source /usr/share/doc/fzf/examples/key-bindings.zsh
