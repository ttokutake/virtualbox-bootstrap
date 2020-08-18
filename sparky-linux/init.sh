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
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew install gcc
echo 'export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"' >> ~/.profile
echo 'export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"' >> ~/.profile

# Vim
brew install vim
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
rm installer.sh

# asdf
brew install asdf
echo '. $(brew --prefix asdf)/asdf.sh' >> ~/.profile
echo '. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash' >> ~/.profile

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip ./aws

# Remove unused packages
sudo apt purge qcalculator xfburn hexchat persepolis pidgin thunderbird qbittorrent libreoffice libreoffice-core libreoffice-common qpdfview skanlite cheese qmmp sparky-tube vlc
sudo apt autoremove
sudo apt autoclean
