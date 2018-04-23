#!/bin/bash
set -euo pipefail

BASHRC=~/.bashrc

echo '### Install Docker CE ###'
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
sudo apt-get update
# apt-cache madison docker-ce
sudo apt-get install -y docker-ce=17.03.2~ce-0~debian-jessie
sudo systemctl enable docker
sudo usermod -aG docker $USER
echo

echo '### Install Docker Compose ###'
sudo curl -Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m`
sudo chmod +x /usr/local/bin/docker-compose
echo

echo '### Install Kubectl'
sudo curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
echo

echo '### Install Minikube ###'
sudo curl -Lo /usr/local/bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo chmod +x /usr/local/bin/minikube
mkdir $HOME/.kube || true
touch $HOME/.kube/config
echo 'export MINIKUBE_WANTUPDATENOTIFICATION=false' >> $BASHRC
echo 'export MINIKUBE_WANTREPORTERRORPROMPT=false'  >> $BASHRC
echo 'export MINIKUBE_HOME=$HOME'                   >> $BASHRC
echo 'export CHANGE_MINIKUBE_NONE_USER=true'        >> $BASHRC
echo 'export KUBECONFIG=$HOME/.kube/config'         >> $BASHRC
echo

# sudo -E minikube start --vm-driver=none
