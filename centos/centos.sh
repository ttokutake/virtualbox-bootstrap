sudo sed -i -E 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo sed -i -E 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

sudo systemctl disable firewalld
