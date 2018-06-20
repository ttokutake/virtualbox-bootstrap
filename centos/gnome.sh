# USER=`whoami`
# sudo sed -i -E 's/AutomaticLoginEnable=.*/AutomaticLoginEnable=True/' /etc/gdm/custom.conf
# sudo sed -i -E "s/AutomaticLogin=.*/AutomaticLogin=$USER/" /etc/gdm/custom.conf

# Rename directory names
LANG=C xdg-user-dirs-gtk-update
