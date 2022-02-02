#! /bin/bash -x

# install/config docker-compose
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo snap disable docker
sudo snap enable docker
echo 'Logout/login to access docker without sudo'

stow vim tmux zsh

# configure vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
