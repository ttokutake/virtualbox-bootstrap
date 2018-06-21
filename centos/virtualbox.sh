# For install VBox Guest Addition
sudo yum install gcc make kernel-devel

# Create shared directory
USER=`whoami`
SHARED_DIR='/media/sf_share'
sudo gpasswd -a $USER vboxsf
ln -s $SHARED_DIR ~/share

# Host Only Network
nmcli c m enp0s8 connection.autoconnect yes
nmcli c modify enp0s8 ipv4.addresses 192.168.56.101/24
nmcli c modify enp0s8 ipv4.gateway 192.168.56.1
nmcli c modify enp0s8 ipv4.dns 192.168.56.1
nmcli c modify enp0s8 ipv4.method manual
nmcli c down enp0s8
nmcli c up enp0s8
