#!/bin/sh


# basic utility
#sudo pacman -S git unzip stow gcin noto-fonts-emoji noto-fonts-cjk texlive-most texlive-lang pass gvim alsa-utils xclip npm wget
# basic application
#sudo pacman -S alacritty qutebrowser nvim nitrogen picom ranger zathura calcurse mpv
#sudo mv /usr/bin/nvim /usr/bin/v


# wallpaper
# ! [ -d $HOME/Picture ] && mkdir $HOME/Picture
# ! [ -d $HOME/Picture/wallPaper ] && mkdir $HOME/Picture/wallPaper
#git clone https://gitlab.com/dwt1/wallpapers.git $HOME/Picture/wallPaper/dt
#git clone https://github.com/BrodieRobertson/wallpapers.git $HOME/Picture/wallPaper/brodie




# suckless tool

# ! [ -d $HOME/suckless ] && mkdir $HOME/suckless
# dependencies
#sudo pacman -S xorg-xinit xorg-setroot xorg-server imlib2 xorg-xrandr

# slock
#git clone https://github.com/opottghjk00/slock_rice $HOME/suckless/slock_rice
#cd $HOME/suckless/slock_rice
#sudo make install

# dwm
#git clone https://github.com/opottghjk00/dwm_rice $HOME/suckless/dwm_rice
#cd $HOME/suckless/dwm_rice
#sudo make install

#dmenu
#git clone https://github.com/opottghjk00/dmenu_rice $HOME/suckless/dmenu_rice
#cd $HOME/suckless/dmenu_rice
#sudo make install



# wifi driver
#sudo pacman -S base-devel dkms bc   # dependencies

# install
#cd $HOME/Document/arch/driver/rtl8821ce_wifi_driver
#sudo ./dkms-install.sh



# bluetooth driver

# isntall
#cd $HOME/Document/arch/driver/asusBt500_bluetooth_driver/usb
#sudo make install

#sudo pacman -S bluez bluez-utils                 # dependencies
#sudo modprobe btusb                              # load the module 
#sudo systemctl enable bluetooth.service          # enable/start the service
#sudo systemctl start bluetooth.service



# zsh
#sudo pacman -S zsh zsh-completions


# configure the application
#git clone https://github.com/opottghjk00/dotfile $HOME/dotfile
#cd $HOME/dotfile
#stow */ 

#emoji fixed
#cd ~/$HOME/Document/arch/libxft-bgra
#sudo pacman -U libxft-bgra-2.3.3.r7.7808631e-1-x86_64.pkg.tar.zst
