#!/bin/bash
set -eo pipefail

if [ ! -e ~/.ssh/id_rsa ]; then
  echo 'Please put "~/.ssh/id_rsa".'
  exit 1
fi

if [ ! -e ~/.gitconfig.private ]; then
  echo 'Please put "~/.gitconfig.private".'
  exit 1
fi
if [ ! -e ~/.gitconfig.work ]; then
  echo 'Please put "~/.gitconfig.work".'
  exit 1
fi

BASHRC=~/.bashrc


echo '### Install essential packages ###'
sudo apt install -y ssh git tree silversearcher-ag direnv bash-completion terminator
echo

echo '### Install vim from the source ###'
VIM_SRC_DIR=~/codes/vim
mkdir -p $VIM_SRC_DIR
git clone https://github.com/vim/vim.git $VIM_SRC_DIR
cd $VIM_SRC_DIR/src
make
sudo make install
cd
echo

echo '### Set essential settings ###'
SETTINGS_DIR=~/codes/settings
mkdir -p $SETTINGS_DIR
git clone git@github.com:ttokutake/settings.git $SETTINGS_DIR
mkdir ~/works
ln -s $SETTINGS_DIR/.envrc ~/.envrc
direnv allow               ~/.envrc
ln -s $SETTINGS_DIR/works/.envrc ~/works/.envrc
direnv allow                     ~/works/.envrc
echo "source $SETTINGS_DIR/.bash_profile" >> $BASHRC
ln -s $SETTINGS_DIR/.vimrc ~/.vimrc
DEIN_DIR=~/.vim/dein/repos/github.com/Shougo/dein.vim
mkdir -p $DEIN_DIR
git clone https://github.com/Shougo/dein.vim.git $DEIN_DIR
echo


echo '### Install asdf ###'
ASDF_DIR=~/.asdf
git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR
SET_ASDF="source $ASDF_DIR/asdf.sh && source $ASDF_DIR/asdf.sh"
echo $SET_ASDF >> $BASHRC
eval $SET_ASDF
sudo apt install -y curl
echo

echo '### Install Erlang ###'
sudo apt install -y build-essential libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
asdf install    erlang 20.0
echo

echo '### Install Elixir ###'
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
asdf install    elixir 1.5.1
echo

echo '### Install Ruby ###'
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby
asdf install    ruby 2.4.1
echo

echo '### Install Node.js ###'
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs
sudo apt install -y dirmngr
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install    nodejs 8.4.0
echo

echo '### Install Rust ###'
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install    rust 1.20.0
echo

echo '### Install Go ###'
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install    golang 1.8
echo

# echo '### Install Swift ###'
# curl -O https://cmake.org/files/v3.9/cmake-3.9.4.tar.gz
# tar xzf cmake-3.9.4.tar.gz
# cd cmake-3.9.4
# ./configure
# make
# sudo make install
# sudo apt install autoconf libblocksruntime-dev
# asdf plugin-add swift
# asdf install    swift 4.0
