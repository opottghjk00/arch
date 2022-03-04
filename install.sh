#!/bin/sh

##################################################################
#		             function 			                         #
##################################################################

function aura_install() {
    git clone https://aur.archlinux.org/aura-bin.git $HOME/repo/arch/res/repo/aura
    cd $HOME/repo/arch/res/repo/aura
    makepkg
    sudo pacman -U *.pkg.tar.zst
}


function packages_install() {
    sudo aura -S unzip stow gcin noto-fonts-emoji noto-fonts-cjk pandoc texlive-most texlive-lang pass gvim alsa-utils 
    sudo aura -S xclip npm wget man-db exa ninja tk tcl xmonad-contrib pulseaudio pulseaudio-bluetooth libnotify 
    sudo aura -S zathura-pdf-mupdf fzf zsh zsh-completions xorg-xinit xorg-xsetroot xorg-server imlib2 xorg-xrandr
    sudo aura -S alacritty qutebrowser nitrogen ranger r mpd ncmpcpp pulsemixer dunst lxappearance pcmanfm rofi starship
    # sudo aura -S mpv (errror)
    sudo aura -A miniconda3 brave-bin polybar qt5-webengine-widevine grive nvim-packer-git picom-jonaburg-git
    # sudo aura -A mutt-wizard abook
    pip install ueberzug PyPtt
    sudo conda install pandas matplotlib numpy scipy seaborn scikit-learn statsmodels
}


function dotfile_set() {
    chsh -s /bin/zsh
    cd $HOME
    [[ ! -d .config ]] && mkdir .config
    [[ ! -d .local ]] && mkdir .local
    mkdir -p .local/bin .local/share
    git clone https://github.com/opottghjk00/dotx.git
    cd $HOME/dotx
    stow */ 
    # sudo cp -f $HOME/.config/mutt/mutt-wizard.muttrc /usr/share/mutt-wizard/mutt-wizard.muttrc
}


function wallPaper_set() {
    mkdir -p $HOME/Document/picture/
    cp -r $HOME/repo/arch/res/wallPaper/ ~/Document/picture/
}


function basic_config() {
    # enable tap click
    cd $HOME/repo/arch/res/setup_file
    sudo cp 30-touchpad.conf /etc/X11/xorg.conf.d/
    # screen locker
    cd $HOME/repo/arch/res/repo/slock_rice
    sudo make clean install
    # another terminal
    cd $HOME/repo/arch/res/repo/st_rice
    sudo make clean install
    # grub theme
    cd $HOME/repo/arch/res/repo/grub_theme
    sudo ./install.sh
}


function driver_setup(){
    # bluetooth driver
    cd $HOME/repo/arch/res/driver/asusBt500_bluetooth_driver/usb
    sudo make install
    sudo aura -S bluez bluez-utils                   # dependencies
    sudo modprobe btusb                              # load the module 
    sudo systemctl enable bluetooth.service          # enable/start the service
    sudo systemctl start bluetooth.service
    # wifi deiver
    git clone https://github.com/tomaspinho/rtl8821ce.git $HOME/repo/arch/res/driver/wifi_driver
    cd $HOME/repo/arch/res/driver/wifi_driver
    sudo ./dkms-install.sh
}


function repo_clone() {
    cd $HOME/repo/
    git clone https://github.com/opottghjk00/leet_code_practice.git
    git clone https://github.com/opottghjk00/sudo_random_password_generator.git
    git clone https://github.com/opottghjk00/ptt_crawler.git
    git clone https://github.com/opottghjk00/newsDL.git
}


function themes_set() {
    cd $HOME/repo/arch/source/themes
    sudo cp -r Nordic-v40/ Nordic-darker-v40/ Nordic-bluish-accent-v40/ /usr/share/themes
    sudo cp -r Nordzy-cursors/ Nordzy-cursors-white/ Zafiro-Icons-Dark/ Zafiro-Icons-Light/ candy-icons/ /usr/share/icons
}


function virt_manager_set() {
    sudo aura -S qemu virt-manager ebtables libvirt lxsession
    sudo systemctl enable libvirtd
    sudo systemctl start libvirtd
    sudo usermod -G libvirt -a jacky
}


#function google_drive_set() {
#    mkdir -p $HOME/Document/google-drive
#    cd $HOME/Document/google-drive
#    grive -a
#}



###################################################################
#		                install process  	                      #
###################################################################

echo "######################################"
echo "#  install the package manager aura  #"
echo "######################################"
aura_install
echo -e "\n\n"

echo "#####################################"
echo "#         install packages          #"
echo "#####################################"
packages_install
echo -e "\n\n"

echo "#####################################"
echo "#        set up the dot file        #"
echo "#####################################"
dotfile_set
echo -e "\n\n"

echo "#####################################"
echo "#         install wallpaper         #"
echo "#####################################"
wallPaper_set
echo -e "\n\n"

echo "#####################################"
echo "#         set up the theme          #"
echo "#####################################"
themes_set
echo -e "\n\n"


echo "#####################################"
echo "#        basic configurattion       #"
echo "#####################################"
basic_config
echo -e "\n\n"

echo "#####################################"
echo "#  set up bluetooth & wifi driver   #"
echo "#####################################"
driver_setup
echo -e "\n\n"

echo "#####################################"
echo "#      download the remote repo     #"
echo "#####################################"
repo_clone
echo -e "\n\n"

echo "#####################################"
echo "#        set up virt manager        #"
echo "#####################################"
virt_manager_set
echo -e "\n\n"

echo "#####################################"
echo "#             reboot...             #"
echo "#####################################"
reboot
