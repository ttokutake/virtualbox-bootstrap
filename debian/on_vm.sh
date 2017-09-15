#!/bin/bash

if [ "`whoami`" != 'root' ]; then
  echo 'Please run as "root".'
  exit 1
fi

USER_NAME="$1"
if [ "$USER_NAME" == '' ]; then
  echo "Usage: bash $0 <User Name>"
  exit 1
fi

set -euo pipefail


echo '### For VBox Guest Additions ###'
apt install -y build-essential module-assistant
m-a prepare
echo

echo '### Add Static Network ###'
echo '####################################################################'
echo '# NOTICE: Assume that VM has "Host-Only Ethernet Adapter" as below #'
echo '#   Address: 192.168.56.1                                          #'
echo '#   Netmask: 255.255.255.0                                         #'
echo '####################################################################'
echo '
  auto eth1
  iface eth1 inet static
  address 192.168.56.101
  netmask 255.255.255.0
' > /etc/network/interfaces.d/eth1
/etc/init.d/networking restart
echo

input=''
while [ "$input" != 'ok' ]; do
  echo -n "Please input \"ok\" after inserting VBox Guest Additions' disc: "
  read input
done
echo '### Install VBox Guest Addisions ###'
MOUNTED_DIR='/media/cdrom'
bash   $MOUNTED_DIR/VBoxLinuxAdditions.run
umount $MOUNTED_DIR
echo

echo '### Set shared directory ###'
SHARED_DIR='/media/sf_share'
gpasswd -a $USER_NAME vboxsf
su - $USER_NAME -c "ln -s $SHARED_DIR ~/share"
echo


echo 'Please reboot Debian.'
