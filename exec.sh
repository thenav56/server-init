#! /bin/bash

_has() {
  return $( whence $1 >/dev/null )
}

install() {
    if _has apt; then
        sudo apt install $@
    elif _has yum; then
        sudo yum install $@
    else
        echo ERROR: could not find apt or yum
        exit 1
    fi
}


# Install common tools
install curl git vim zsh tmux docker

# install oh-my-zsh [https://github.com/robbyrussell/oh-my-zsh]
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc.default
cp ./configs/zshrc $HOME/.zshrc
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
cp ./configs/tmux.conf $HOME/.tmux.conf

# configure vim
VIM_DIR=$HOME/.vim
mkdir $VIM_DIR
cp ./configs/vimrc $VIM_DIR/vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# install/config docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo gpasswd -a $USER docker
docker-compose --version
