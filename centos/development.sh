# Install Linuxbrew for vim and git
sudo yum groupinstall 'Development Tools' && sudo yum install curl file git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
#test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
#test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
#test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
brew install vim git
echo 'alias vim="PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH vim"' >> ~/.bashrc
echo 'alias git="PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH git"' >> ~/.bashrc

# Utility
sudo yum install tree direnv jq

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

. ~/.asdf/asdf.sh
. ~/.asdf/completions/asdf.bash

# For Node.js
asdf plugin-add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# For Ruby
asdf plugin-add ruby

# For Python
yum install gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel
asdf plugin-add python

# Install docker-ce
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
sudo systemctl enable docker
sudo usermod -aG docker `whoami`
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install AWS CLI
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py
sudo pip install awscli
rm get-pip.py
