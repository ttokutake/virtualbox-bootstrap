#!/bin/bash -euo

CODE_DIR=~/codes
BASHRC=~/.bashrc


### Install essential packages ###
sudo apt install -y vim ssh git tree silversearcher-ag direnv bash-completion terminator


### Set essential settings ###
SETTINGS_DIR=$CODE_DIR/settings
SETTINGS_REPO=git@github.com:ttokutake/settings.git
mkdir -p $SETTINGS_DIR
git clone $SETTINGS_REPO $SETTINGS_DIR
mkdir ~/works
ln -s $SETTINGS_DIR/.envrc ~/.envrc
direnv allow               ~/.envrc
ln -s $SETTINGS_DIR/works/.envrc ~/works/.envrc
direnv allow                     ~/works/.envrc
echo "source $SETTINGS_DIR/.bash_profile" >> $BASHRC
ln -s $SETTINGS_DIR/.vimrc ~/.vimrc
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
asdf install    erlang 20.0

### Install Elixir ###
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
asdf install    elixir 1.5.1

### Install Ruby ###
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby
asdf install    ruby 2.4.1
gem install bundler

### Install Node.js ###
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs
asdf install    nodejs 8.4.0

### Install Rust ###
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install    rust 1.20.0

### Install Go ###
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install    golang 1.8


### Install Phoenix Framework ###
sudo apt install inotify-tools
mix local.hex --force
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
