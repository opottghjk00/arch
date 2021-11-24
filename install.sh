#!/bin/sh
# use the command "sudo ./install.sh"
# current working directory is $HOME/repo/github/os_set/arch


function aura_install() {
    tar xvzf ./source/aura-bin.tar.gz
    cd $HOME/repo/github/os_set/arch/aura-bin
    makepkg
    sudo pacman -U aura-bin-3.2.6-1-x86_64.pkg.tar.zst
}


# install packages
function packages_install() {
    sudo aura -S git unzip stow gcin noto-fonts-emoji noto-fonts-cjk pandoc texlive-most texlive-lang pass gvim alsa-utils xclip npm wget python-pip man-db exa ninja tk tcl xmonad-contrib pulseaudio pulseaudio-bluetooth libnotify zathura-pdf-mupdf fzf zsh zsh-completions
    sudo aura -S alacritty qutebrowser nvim nitrogen picom ranger zathura calcurse mpv r xmonad mpd ncmpcpp pulsemixer dunst lxappearance qt5ct pcmanfm cairo-dock rofi
    sudo aura -A brave-bin polybar notion-app mutt-wizard abook miniconda3 qt5-webengine-widevine grive nvim-packer-git
    pip install ueberzug
}


# configure the dotfile
function dotfile_set() {
    cd $HOME
    git clone https://github.com/opottghjk00/dotx.git
    cd $HOME/dotx
    stow */ 
}


# wallpaper
function wallPaper_set() {
    mkdir -p $HOME/Document/picture/
    cp -r $HOME/repo/github/os_set/arch/source/wallpaper ~/Document/picture/
}


# set wifi driver
function wifiDrier_ser() {
    sudo aura -S base-devel dkms bc   # dependencies
    cd $HOME/repo/github/os_set/arch/driver/rtl8821ce_wifi_driver
    sudo ./dkms-install.sh
}


# set bluetooth driver
function bluetoothDiver_set(){
    cd $HOME/repo/github/os_set/arch/driver/asusBt500_bluetooth_driver/usb
    sudo make install
    sudo aura -S bluez bluez-utils                 # dependencies
    sudo modprobe btusb                              # load the module 
    sudo systemctl enable bluetooth.service          # enable/start the service
    sudo systemctl start bluetooth.service
}


# clone repo
# slock
function repo_clone() {
    sudo aura -S xorg-xinit xorg-setroot xorg-server imlib2 xorg-xrandr
    cd $HOME/repo/github/
    git clone https://github.com/opottghjk00/slock_rice.git
    cd slock_rice
    sudo make install
}


# setup themes
function themes_set() {
    cd $HOME/repo/github/os_set/arch/source/themes
    sudo cp -r Nordic-v40/ Nordic-darker-v40/ Nordic-bluish-accent-v40/ /usr/share/themes
    sudo cp -r Nordzy-cursors/ Nordzy-cursors-white/ Zafiro-Icons-Dark/ Zafiro-Icons-Light/ candy-icons/ /usr/share/icons
}


# nvim -jupyter notebook set
#pip install jupyter_ascending
#jupyter nbextension install --py --sys-prefix jupyter_ascending
#jupyter nbextension     enable jupyter_ascending --sys-prefix --py
#jupyter serverextension enable jupyter_ascending --sys-prefix --py

