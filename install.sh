#!/bin/sh
# use the command "sudo ./install.sh"
# current working directory is $HOME/repo/github/os_set/arch



# package manager -aura

#tar xvzf ./source/aura-bin.tar.gz
#cd ./source/aura-bin
#makepkg
#sudo pacman -U aura-bin-3.2.6-1-x86_64.pkg.tar.zst


# basic utility
#sudo aura -S git unzip stow gcin noto-fonts-emoji noto-fonts-cjk pandoc texlive-most texlive-lang pass gvim alsa-utils xclip npm wget python-pip man-db exa ninja tk tcl xmonad-contrib pulseaudio pulseaudio-bluetooth rofi libnotify lynx cronie zathura-pdf-mupdf cairo-dock-plug-ins
#pip install ueberzug

# basic application
#sudo aura -S alacritty qutebrowser nvim nitrogen picom ranger zathura calcurse mpv r xmonad mpd ncmpcpp pulsemixer dunst lxappearance qt5ct pcmanfm cairo-dock
#sudo aura -A brave-bin polybar notion-app mutt-wizard abook miniconda3 qt5-webengine-widevine


# wallpaper
# ! [ -d $HOME/Document/picture/ ] && mkdir -p $HOME/Document/picture/
#cp -r ./source/wallpaper ~/Document/picture/wallpaper



# wifi driver
#sudo pacman -S base-devel dkms bc   # dependencies
#cd $HOME/repo/github/os_setup/arch/driver/rtl8821ce_wifi_driver
#sudo ./dkms-install.sh



# bluetooth driver
#cd $HOME/repo/github/os_setup/arch/driver/asusBt500_bluetooth_driver/usb
#sudo make install

#sudo pacman -S bluez bluez-utils                 # dependencies
#sudo modprobe btusb                              # load the module 
#sudo systemctl enable bluetooth.service          # enable/start the service
#sudo systemctl start bluetooth.service


# slock
# dependencies
#sudo pacman -S xorg-xinit xorg-setroot xorg-server imlib2 xorg-xrandr

#git clone https://github.com/opottghjk00/slock_rice $HOME/repo/github/slock_rice
#cd $HOME/repo/github/slock_rice
#sudo make install


# zsh
#sudo aura -S zsh zsh-completions

# themes
#cd source/themes
#sudo cp -r Nordic-v40/ Nordic-darker-v40/ Nordic-bluish-accent-v40 /usr/share/themes
#sudo cp -r Nordzy-cursors/ Nordzy-cursors-white/ Zafiro-Icons-Dark/ Zafiro-Icons-Light/ candy-icons/ /usr/share/icons


# configure the application
#git clone https://github.com/opottghjk00/dotfile $HOME/dotfile
#cd $HOME/dotfile
#stow */ 


# nvim -jupyter notebook set
#pip install jupyter_ascending
#jupyter nbextension install --py --sys-prefix jupyter_ascending
#jupyter nbextension     enable jupyter_ascending --sys-prefix --py
#jupyter serverextension enable jupyter_ascending --sys-prefix --py

