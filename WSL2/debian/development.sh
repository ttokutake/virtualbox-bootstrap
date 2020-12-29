sudo apt update
sudo apt dist-upgrade

# Linuxbrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo apt install build-essential curl file git
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/ttokutake/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# GCC
brew install gcc
echo 'export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"' >> /home/ttokutake/.profile
echo 'export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"' >> /home/ttokutake/.profile

# Vim
brew install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Keychain
brew install keychain
echo '/home/linuxbrew/.linuxbrew/bin/keychain --nogui $HOME/.ssh/id_rsa' >> /home/ttokutake/.profile
echo 'source $HOME/.keychain/$HOSTNAME-sh' >> /home/ttokutake/.profile

# bash-completion
# TBD

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
echo '. $HOME/.asdf/asdf.sh' >> /home/ttokutake/.profile
echo '. $HOME/.asdf/completions/asdf.bash' >> /home/ttokutake/.profile
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Node.js
brew install gpg
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
