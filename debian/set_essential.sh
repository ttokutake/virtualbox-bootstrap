USER_NAME=$1


### For VBox Guest Additions ###
apt install -y build-essential module-assistant
m-a prepare -y

### Enable for $USER_NAME to use "sudo" command ###
SUDOERS_FILE=/etc/sudoers
chmod 600 $SUDOERS_FILE
echo "$USER_NAME ALL=(ALL:ALL) ALL" >> $SUDOERS_FILE
chmod 440 $SUDOERS_FILE

### Pass through GRUB menu ###
GRUB_CONFIG_FILE=/etc/default/grub
sed -re 's/^GRUB_TIMEOUT=[0-9]+$/GRUB_TIMEOUT=0/' $GRUB_CONFIG_FILE -i
update-grub

### Install essential packages ###
apt install -y vim git tree bash-completion terminator
