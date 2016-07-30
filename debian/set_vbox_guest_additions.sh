USER_NAME=$1


### Install VBox Guest Addisions ###
MOUNTED_DIR=/media/cdrom
bash $MOUNTED_DIR/VBoxLinuxAdditions.run

### Set shared directory ###
SHARED_DIR=/media/sf_share
gpasswd -a $USER_NAME vboxsf
su - $USER_NAME -c "ln -s $SHARED_DIR ~/share"
