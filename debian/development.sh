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
echo >> $BASHRC


echo '### Install essential packages ###'
sudo apt install -y ssh git tree direnv bash-completion
echo 'source /etc/bash_completion.d/git-prompt' >> $BASHRC
echo                                            >> $BASHRC
echo

echo '### Set essential settings ###'
SETTINGS_DIR=~/codes/settings
mkdir -p $SETTINGS_DIR
git clone git@github.com:ttokutake/settings.git $SETTINGS_DIR
echo "source $SETTINGS_DIR/.bash_profile" >> $BASHRC
echo                                      >> $BASHRC
ln -s $SETTINGS_DIR/.vimrc ~/.vimrc

mkdir ~/works
ln -s $SETTINGS_DIR/.envrc ~/.envrc
direnv allow               ~/.envrc
ln -s $SETTINGS_DIR/works/.envrc ~/works/.envrc
direnv allow                     ~/works/.envrc
echo 'eval "$(direnv hook bash)"' >> $BASHRC
echo                              >> $BASHRC

DEIN_DIR=~/.vim/dein/repos/github.com/Shougo/dein.vim
mkdir -p $DEIN_DIR
git clone https://github.com/Shougo/dein.vim.git $DEIN_DIR
echo


echo '### Install asdf ###'
ASDF_DIR=~/.asdf
git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR
SET_ASDF="source $ASDF_DIR/asdf.sh && source $ASDF_DIR/asdf.sh"
echo $SET_ASDF >> $BASHRC
echo           >> $BASHRC
eval $SET_ASDF
sudo apt install -y curl
echo

echo '### Install Node.js ###'
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs
sudo apt install -y dirmngr
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 10.15.0
echo
