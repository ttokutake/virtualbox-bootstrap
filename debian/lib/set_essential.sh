USER_NAME=$1


### For VBox Guest Additions ###
apt install -y build-essential module-assistant
m-a prepare

### Enable for $USER_NAME to use "sudo" command ###
SUDOERS_FILE=/etc/sudoers
chmod 600 $SUDOERS_FILE
echo "$USER_NAME ALL=(ALL:ALL) ALL" >> $SUDOERS_FILE
chmod 440 $SUDOERS_FILE

### Pass through GRUB menu ###
GRUB_CONFIG_FILE=/etc/default/grub
sed -re 's/^GRUB_TIMEOUT=[0-9]+$/GRUB_TIMEOUT=0/' $GRUB_CONFIG_FILE -i
update-grub

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


### Install essential packages ###
apt install -y vim ssh git tree bash-completion terminator

### Change directories' name from JPN to EN
apt install xdg-user-dirs-gtk
su - $USER_NAME -c 'LANG=C xdg-user-dirs-gtk-update'
### NOTICE: Check "Don't ask me again" box ###

### Remove unused packages ###
apt-get purge -y pluma galculator firefox-esr libreoffice-common libreoffice-core gimp gnome-orca
apt-get autoremove --purge -y
apt-get autoclean
