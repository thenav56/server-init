#! /bin/bash

install() {
    sudo yum install -y $@
}

# Generate files
cat <<EOT >> /tmp/.zshrc
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

plugins=(
    git vi-mode docker docker-compose zsh_reload django tmux
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

[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh
EOT


cat <<EOT >> /tmp/.tmux.conf
# switch panes using Ctrl-arrow without prefix
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

bind-key C-o rotate-window

# Enable mouse control (clickable windows, panes, resizable panes)
# set -g mouse on
# set -g mouse-select-window on
# set -g mouse-select-pane on
# set -g mouse-resize-pane on
set -g mouse on

# reload config file (change file location to your the tmux.conf you want to use)
bind r source-file ~/.tmux.conf
EOT


cat <<EOT >> /tmp/vimrc
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

let mapleader = ','
nmap <C-P> :Files <CR>
nmap <leader>bs :History<cr>                " Search Files History
EOT

# Install common tools
install curl git vim zsh tmux docker

# install oh-my-zsh [https://github.com/robbyrussell/oh-my-zsh]
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc.default
cp /tmp/.zshrc $HOME/.zshrc

chsh -s $(which zsh) $USER
    if ! [ $? -eq 0 ]; then
        echo '
            export SHELL=`which zsh`
            [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l'\
        | sed -e 's/^[ \t]*//' | cat >> $HOME/.bash_profile
    fi

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all

# configure tmux
cp /tmp/.tmux.conf $HOME/.tmux.conf

# configure vim
VIM_DIR=$HOME/.vim
mkdir $VIM_DIR
cp /tmp/vimrc $VIM_DIR/vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# install/config docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo gpasswd -a $USER docker
docker-compose --version
