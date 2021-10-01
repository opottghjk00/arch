#!/bin/sh
# use the command "sudo ./install.sh"


# package manager -aura
#tar xvzf ./source/aura-bin.tar.gz
#cd ./source/aura-bin
#makepkg
#sudo pacman -U aura-bin-3.2.6-1-x86_64.pkg.tar.zst


# basic utility
#sudo aura -S git unzip stow gcin noto-fonts-emoji noto-fonts-cjk pandoc texlive-most texlive-lang pass gvim alsa-utils xclip npm wget python-pip man-db exa ninja tk tcl xmonad-contrib pulseaudio pulseaudio-bluetooth rofi libnotify lynx cronie
#pip install ueberzug
# basic application
#sudo aura -S alacritty qutebrowser nvim nitrogen picom ranger zathura calcurse mpv r xmonad mpd ncmpcpp pulsemixer dunst
#sudo aura -A brave-bin polybar notion-app mutt-wizard abook miniconda3
#sudo mv /usr/bin/nvim /usr/bin/v



# wallpaper
# ! [ -d $HOME/Document/Picture/wallPaper ] && mkdir -p $HOME/Document/Picture/wallPaper
#git clone https://gitlab.com/dwt1/wallpapers.git $HOME/Document/Picture/wallPaper/dt
#git clone https://github.com/BrodieRobertson/wallpapers.git $HOME/Document/Picture/wallPaper/brodie



# wifi driver
#sudo pacman -S base-devel dkms bc   # dependencies
#cd $HOME/repo/github/linux_setup/arch/driver/rtl8821ce_wifi_driver
#sudo ./dkms-install.sh



# bluetooth driver
#cd $HOME/repo/github/linux_setup/arch/driver/asusBt500_bluetooth_driver/usb
#sudo make install

#sudo pacman -S bluez bluez-utils                 # dependencies
#sudo modprobe btusb                              # load the module 
#sudo systemctl enable bluetooth.service          # enable/start the service
#sudo systemctl start bluetooth.service


# qutebrowser netflix fix
#tar xvzf ./source/qt5-webengine-widevine.tar.gz
#cd ./source/qt5-webengine-widevine
#makepkg
#sudo aura -U qt5-webengine-widevine-93.0.4577.63-1-x86_64.pkg.tar.zst




# slock
# dependencies
#sudo pacman -S xorg-xinit xorg-setroot xorg-server imlib2 xorg-xrandr

#git clone https://github.com/opottghjk00/slock_rice $HOME/repo/github/slock_rice
#cd $HOME/repo/github/slock_rice
#sudo make install


# zsh
#sudo aura -S zsh zsh-completions


# configure the application
#git clone https://github.com/opottghjk00/dotfile $HOME/dotfile
#cd $HOME/dotfile
#stow */ 


# nvim -jupyter notebook set
#pip install jupyter_ascending
#jupyter nbextension install --py --sys-prefix jupyter_ascending
#jupyter nbextension     enable jupyter_ascending --sys-prefix --py
#jupyter serverextension enable jupyter_ascending --sys-prefix --py

