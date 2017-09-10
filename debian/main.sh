#!/bin/bash -euo

if [ "`whoami`" != 'root' ]; then
  echo 'Please run as "root".'
  exit 1
fi

USER_NAME="$1"
if [ "$USER_NAME" == '' ]; then
  echo "Usage: bash -euo $0 <User Name>"
  exit 1
fi

SCRIPT_DIR="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"
LIB_DIR="$SCRIPT_DIR/lib"


apt update
apt upgrade -y

### For VBox Guest Additions ###
apt install -y build-essential module-assistant
m-a prepare

### Enable for $USER_NAME to use "sudo" command ###
SUDOERS_FILE='/etc/sudoers'
chmod 600 $SUDOERS_FILE
echo "$USER_NAME ALL=(ALL:ALL) ALL" >> $SUDOERS_FILE
chmod 440 $SUDOERS_FILE

### Pass through GRUB menu ###
GRUB_CONFIG_FILE='/etc/default/grub'
sed -re 's/^(GRUB_TIMEOUT=)[0-9]+$/\10/' $GRUB_CONFIG_FILE -i
update-grub

### Pass through LightDM Login ###
LIGHT_DM_CONFIG_FILE='/etc/lightdm/lightdm.conf'
sed -re "s/^#(autologin-user=).*$/\1$USER_NAME/" $LIGHT_DM_CONFIG_FILE -i
sed -re 's/^#(autologin-user-timeout=.*)$/\1/'   $LIGHT_DM_CONFIG_FILE -i

### Add Static Network ###
echo '
  auto eth1
  iface eth1 inet static
  address 192.168.56.101
  netmask 255.255.255.0
' > /etc/network/interfaces.d/eth1
/etc/init.d/networking restart
### NOTICE: Assume that VM has "Host-Only Ethernet Adapter" as below ###
###   Address: 192.168.56.1                                          ###
###   Netmask: 255.255.255.0                                         ###


### Change directories' name from JPN to EN
apt install xdg-user-dirs-gtk
su - $USER_NAME -c 'LANG=C xdg-user-dirs-gtk-update'
### NOTICE: Check "Don't ask me again" box ###

### Remove unused packages ###
apt-get purge -y pluma galculator firefox-esr libreoffice-common libreoffice-core gimp gnome-orca
apt-get autoremove --purge -y
apt-get autoclean


input=''
while [ "$input" != 'ok' ]; do
  echo -n "Please input \"ok\" after inserting VBox Guest Additions' disc: "
  read input
done
### Install VBox Guest Addisions ###
MOUNTED_DIR='/media/cdrom'
bash   $MOUNTED_DIR/VBoxLinuxAdditions.run
umount $MOUNTED_DIR

### Set shared directory ###
SHARED_DIR='/media/sf_share'
gpasswd -a $USER_NAME vboxsf
su - $USER_NAME -c "ln -s $SHARED_DIR ~/share"


echo 'Please reboot Debian.'
