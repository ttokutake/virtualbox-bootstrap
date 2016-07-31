#!/bin/bash

CODE_DIR=~/codes
BASHRC=~/.bashrc


### Set essential settings ###
SETTINGS_DIR=$CODE_DIR/settings
SETTINGS_REPO=git@github.com:ttokutake/settings.git
mkdir -p $SETTINGS_DIR
git clone $SETTINGS_REPO $SETTINGS_DIR
echo "source $SETTINGS_DIR/.bash_profile" >> $BASHRC
ln -s $SETTINGS_DIR/.gitconfig ~/.gitconfig
ln -s $SETTINGS_DIR/.vimrc     ~/.vimrc
DEIN_DIR=~/.vim/dein/repos/github.com/Shougo/dein.vim
DEIN_REPO=https://github.com/Shougo/dein.vim.git
mkdir -p $DEIN_DIR
git clone $DEIN_REPO $DEIN_DIR


### Install asdf ###
ASDF_REPO=https://github.com/asdf-vm/asdf.git
ASDF_DIR=~/.asdf
git clone $ASDF_REPO $ASDF_DIR
SET_ASDF="source $ASDF_DIR/asdf.sh && source $ASDF_DIR/asdf.sh"
echo $SET_ASDF >> $BASHRC
eval $SET_ASDF

### Install Erlang ###
sudo apt install -y build-essential libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
asdf install    erlang 19.0
asdf global     erlang 19.0

### Install Elixir ###
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
asdf install    elixir 1.3.2
asdf global     elixir 1.3.2

### Install Ruby ###
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby
asdf install    ruby 2.3.1
asdf global     ruby 2.3.1

### Install Node.js ###
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs
asdf install    nodejs 4.4.7
asdf global     nodejs 4.4.7


### Install Rust ###
sudo apt -y install curl
curl -sf -L https://static.rust-lang.org/rustup.sh | sh


### Install Phoenix Framework ###
sudo apt install inotify-tools
mix local.hex --force
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
