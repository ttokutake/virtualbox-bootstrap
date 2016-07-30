#!/bin/bash

if [ `whoami` != 'root' ]; then
  echo 'Please run as "root".'
  exit 1
fi

USER_NAME=$1
if [ "$USER_NAME" == '' ]; then
  echo "Usage: bash $0 <User Name>"
  exit 1
fi

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)


apt update
apt upgrade -y

bash $SCRIPT_DIR/set_essential.sh $USER_NAME

input=''
while [ "$input" != 'ok' ]; do
  echo -n "Please input \"ok\" after inserting VBox Guest Additions' disc: "
  read input
done
bash $SCRIPT_DIR/set_vbox_guest_additions.sh $USER_NAME

echo 'Please reboot Debian.'
