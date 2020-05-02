# VBox Guest Additions のために必要
sudo apt-get install linux-headers-$(uname -r)

# VBox 共有フォルダのために必要
sudo usermod -aG vboxsf ${USER}

# GRUB
GRUB_CONFIG_FILE='/etc/default/grub'
sudo sed -re 's/^(GRUB_TIMEOUT=)[0-9]+$/\10/' $GRUB_CONFIG_FILE -i
sudo update-grub

# ディレクトリ名の英語化
LANG=C xdg-user-dirs-gtk-update

# Linuxbrew
sudo apt-get install build-essential curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.bash_profile
echo 'eval "$($(brew --prefix)/bin/brew shellenv)"' >> ~/.bashrc

# Vim
brew install vim
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
rm installer.sh

# direnv
brew install direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

# asdf
brew install asdf
echo '. $(brew --prefix asdf)/asdf.sh' >> ~/.bash_profile
echo '. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash' >> ~/.bash_profile

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
