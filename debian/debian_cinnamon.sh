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


echo "### Enable for $USER_NAME to use \"sudo\" command ###"
SUDOERS_FILE='/etc/sudoers'
chmod 600 $SUDOERS_FILE
echo "$USER_NAME ALL=(ALL:ALL) ALL" >> $SUDOERS_FILE
chmod 440 $SUDOERS_FILE
echo

echo '### Pass through GRUB menu ###'
GRUB_CONFIG_FILE='/etc/default/grub'
sed -re 's/^(GRUB_TIMEOUT=)[0-9]+$/\10/' $GRUB_CONFIG_FILE -i
update-grub
echo

echo '### Pass through LightDM Login ###'
LIGHT_DM_CONFIG_FILE='/etc/lightdm/lightdm.conf'
sed -re "s/^#(autologin-user=).*$/\1$USER_NAME/" $LIGHT_DM_CONFIG_FILE -i
sed -re 's/^#(autologin-user-timeout=.*)$/\1/'   $LIGHT_DM_CONFIG_FILE -i
echo

echo '### Change directory names from JPN to EN'
apt install xdg-user-dirs-gtk
echo '###############################################'
echo '### NOTICE: Check "Do not ask me again" box ###'
echo '###############################################'
su - $USER_NAME -c 'LANG=C xdg-user-dirs-gtk-update'
echo

echo '### Remove unused packages ###'
apt purge -y chromium firefox-esr thunderbird brasero gimp hexchat cheese gnome-games libreoffice-common rhythmbox pidgin gnote shotwell sound-juicer transmission-common
apt autoremove --purge -y
apt autoclean
echo

echo '### Increase vm.max_map_count ###'
echo 'vm.max_map_count = 262144' >> /etc/sysctl.conf
sysctl -p
echo

echo '### Install chrony'
apt install chrony
echo '' >> /etc/chrony/chrony.conf
echo 'server ntp.nict.jp iburst' >> /etc/chrony/chrony.conf
echo 'server ntp1.jst.mfeed.ad.jp iburst' >> /etc/chrony/chrony.conf
echo 'server ntp2.jst.mfeed.ad.jp iburst' >> /etc/chrony/chrony.conf
echo 'server ntp3.jst.mfeed.ad.jp iburst' >> /etc/chrony/chrony.conf
echo '' >> /etc/chrony/chrony.conf
echo 'allow 192.168.11.0/24' >> /etc/chrony/chrony.conf
echo '' >> /etc/chrony/chrony.conf
echo 'leapsecmode slew' >> /etc/chrony/chrony.conf
echo 'maxslewrate 1000' >> /etc/chrony/chrony.conf
echo 'smoothtime 400 0.001 leaponly' >> /etc/chrony/chrony.conf
systemctl restart chrony
systemctl enable chrony

echo 'Please reboot Debian.'
