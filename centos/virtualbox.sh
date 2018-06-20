# For install VBox Guest Addition
sudo yum install gcc make kernel-devel

# Create shared directory
USER=`whoami`
SHARED_DIR='/media/sf_share'
sudo gpasswd -a $USER vboxsf
ln -s $SHARED_DIR ~/share
