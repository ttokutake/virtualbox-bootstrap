sudo sed -i -E 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo sed -i -E 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

# echo 'vm.max_map_count=262144' >> /etc/sysctl.conf

sudo systemctl disable firewalld
