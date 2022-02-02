#! /bin/bash -xe

sudo apt-get update -y

# Install common tools
sudo apt-get install -y curl git vim zsh tmux fzf stow

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm ~/.zshrc
