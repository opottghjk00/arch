#!/bin/sh

##################################################################
#		             function 			                         #
##################################################################

# install package manager aura
function aura_install() {
    tar xvzf $HOME/repo/arch/source/aura-bin.tar.gz
    cd $HOME/repo/arch/aura-bin
    makepkg
    sudo pacman -U aura-bin-3.2.6-1-x86_64.pkg.tar.zst
}


# install packages
function packages_install() {
    sudo aura -S unzip stow gcin noto-fonts-emoji noto-fonts-cjk pandoc texlive-most texlive-lang pass gvim alsa-utils xclip npm wget man-db exa ninja tk tcl xmonad-contrib pulseaudio pulseaudio-bluetooth libnotify zathura-pdf-mupdf fzf zsh zsh-completions
    sudo aura -S alacritty qutebrowser nitrogen ranger r mpd ncmpcpp pulsemixer dunst lxappearance pcmanfm rofi starship
    # sudo aura -S mpv (errror)
    sudo aura -A brave-bin polybar qt5-webengine-widevine grive nvim-packer-git picom-jonaburg-git
    # sudo aura -A  miniconda3 mutt-wizard abook
    pip install ueberzug
}


# configure the dotfile
function dotfile_set() {
    chsh -s /bin/zsh
    cd $HOME
    [[ ! -d .config ]] && mkdir .config
    mkdir -p .local/bin .local/share
    git clone https://github.com/opottghjk00/dotx.git
    cd $HOME/dotx
    stow */ 
    sudo cp -f $HOME/.config/mutt/mutt-wizard.muttrc /usr/share/mutt-wizard/mutt-wizard.muttrc
}


# wallpaper
function wallPaper_set() {
    mkdir -p $HOME/Document/picture/
    cp -r $HOME/repo/arch/source/wallpaper ~/Document/picture/
}


# set wifi driver
function enable_tap_click() {
    cd $HOME/repo/arch/source
    sudo cp 30-touchpad.conf /etc/X11/xorg.conf.d/
}


# set bluetooth driver
function bluetoothDiver_set(){
    cd $HOME/repo/arch/driver/asusBt500_bluetooth_driver/usb
    sudo make install
    sudo aura -S bluez bluez-utils                 # dependencies
    sudo modprobe btusb                              # load the module 
    sudo systemctl enable bluetooth.service          # enable/start the service
    sudo systemctl start bluetooth.service
}


# clone repo
function repo_clone() {
    sudo aura -S xorg-xinit xorg-xsetroot xorg-server imlib2 xorg-xrandr
    cd $HOME/repo/
    git clone https://github.com/opottghjk00/slock_rice.git
    git clone https://github.com/opottghjk00/st_rice.git
    git clone https://github.com/opottghjk00/leet_code_practice.git
    git clone https://github.com/opottghjk00/sudo_random_password_generator.git
    git clone https://github.com/opottghjk00/ptt_crawler.git
    git clone https://github.com/opottghjk00/newsDL.git
    git clone https://github.com/tomaspinho/rtl8821ce.git
    cd $HOME/repo/rtl8821ce
    sudo ./install.sh
    cd $HOME/repo/slock_rice
    sudo make clean install
    cd $HOME/repo/st_rice
    sudo make clean install
}


# setup themes
function themes_set() {
    cd $HOME/repo/arch/source/themes
    sudo cp -r Nordic-v40/ Nordic-darker-v40/ Nordic-bluish-accent-v40/ /usr/share/themes
    sudo cp -r Nordzy-cursors/ Nordzy-cursors-white/ Zafiro-Icons-Dark/ Zafiro-Icons-Light/ candy-icons/ /usr/share/icons
}


#function google_drive_set() {
#    mkdir -p $HOME/Document/google-drive
#    cd $HOME/Document/google-drive
#    grive -a
#}


function virt_manager_set() {
    sudo aura -S qemu virt-manager ebtables libvirt lxsession
    sudo systemctl enable libvirtd
    sudo systemctl start libvirtd
    sudo usermod -G libvirt -a jacky
}


###################################################################
#		                install process  	                      #
###################################################################

echo "-----------------------------------------------------------------------------"
echo "install the package manager aura"
echo "-----------------------------------------------------------------------------"
aura_install

echo "-----------------------------------------------------------------------------"
echo "install packages"
echo "-----------------------------------------------------------------------------"
packages_install

echo "-----------------------------------------------------------------------------"
echo "set up the dot file"
echo "-----------------------------------------------------------------------------"
dotfile_set

echo "-----------------------------------------------------------------------------"
echo "install wallpaper"
echo "-----------------------------------------------------------------------------"
wallPaper_set

echo "-----------------------------------------------------------------------------"
echo "set up the theme"
echo "-----------------------------------------------------------------------------"
themes_set


echo "-----------------------------------------------------------------------------"
echo "enable tap click"
echo "-----------------------------------------------------------------------------"
enable_tap_click

echo "-----------------------------------------------------------------------------"
echo "set up bluetooth usb driver"
echo "-----------------------------------------------------------------------------"
bluetoothDiver_set

echo "-----------------------------------------------------------------------------"
echo "download the remote repo and have basic setup"
echo "-----------------------------------------------------------------------------"
repo_clone

echo "-----------------------------------------------------------------------------"
echo "set up virt manager"
echo "-----------------------------------------------------------------------------"
virt_manager_set

echo "-----------------------------------------------------------------------------"
echo "reboot..."
echo "-----------------------------------------------------------------------------"
reboot
