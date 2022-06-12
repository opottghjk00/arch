#!/bin/sh


##################################################
#		             function 			         #
##################################################

# basic packages install
function basic_packages_install(){
    sudo pacman -S linux-lts-headers base-devel gcin noto-fonts-emoji noto-fonts-cjk dkms bc
    sudo pacman -S xorg-xinit xorg-xsetroot xorg-server imlib2 xorg-xrandr
    sudo pacman -S zsh zsh-completions pass git unzip
    sudo pacman -S xclip npm wget man-db exa ninja tk tcl xmonad-contrib libnotify fzf
    sudo pacman -S alacritty nitrogen mpv r xmonad dunst lxappearance pcmanfm rofi starship
}


# install AUR helper
function AUR_packages_install(){
    [[ ! -d $HOME/Document ]] && mkdir $HOME/Document
    mkdir -p $HOME/Document/open_source
    git clone https://aur.archlinux.org/yay.git $HOME/open_source/yay
    cd $HOME/open_source/yay
    makepkg -si
    sudo yay -S brave-bin polybar miniconda3 grive picom-jonaburg-git notion-app
}


# configure the dotfile
function dotfile_set(){
    sudo pacman -S stow
    [[ ! -d $HOME/.config ]] && mkdir $HOME/.config
    [[ ! -d $HOME/.local ]] && mkdir $HOME/.local
    mkdir -p $HOME/.local/bin $HOME/.local/share
    git clone https://github.com/opottghjk00/dotx.git $HOME/dotx
    cd $HOME/dotx
    stow */ 
}

function additional_system_setup(){
    sudo cp $HOME/repo/archSetup/res/utils/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf
}

# setup documentation work
function documentation_setup(){
    sudo pacman -S gvim neovim zathura evince pandoc texlive-most texlive-lang zathura-pdf-mupdf
    git clone https://github.com/opottghjk00/nvimIDE.git $HOME/repo/nvimIDE
    ln -s $HOME/repo/nvimIDE $HOME/.config/nvim
}


# setup sound system
function sound_system_setup(){
    sudo pacman -S pipewire pipewire-pulse
    systemctl start pipewire-pulse.service
}


# wallpaper
function wallPaper_setup(){
    mkdir -p $HOME/Document/picture/wallpaper
    ln -s $HOME/repo/archSetup/res/wallpaper ~/Document/picture/wallpaper
}


# set wifi driver
function wifiDrier_setup(){
    # if no wifi
    # cd $HOME/repo/arch/driver/rtl8821ce_wifi_driver
    # sudo ./dkms-install.sh
    git clone https://github.com/tomaspinho/rtl8821ce.git $HOME/Document/open_source/rtl8821ce
    cd $HOME/Document/open_source/rtl8821ce
    sudo ./dkms-install.sh
}


# set bluetooth driver
function bluetoothDiver_setup(){
    cd $HOME/repo/arch/driver/asusBt500_bluetooth_driver/usb
    sudo make install
    sudo pacman -S bluez bluez-utils                 # dependencies
    sudo modprobe btusb                              # load the module 
    sudo systemctl enable bluetooth.service          # enable/start the service
    sudo systemctl start bluetooth.service
}


# clone repo
function repo_clone(){
    git clone https://github.com/opottghjk00/slock_rice.git $HOME/repo/slock_rice
    git clone https://github.com/opottghjk00/st_rice.git $HOME/repo/st_rice
    git clone https://github.com/opottghjk00/leet_code_practice.git $HOME/repo/leet_code_practice
    git clone https://github.com/opottghjk00/dwm_rice.git $HOME/repo/dwm_rice
    git clone https://github.com/opottghjk00/BasicIntegration.jl $HOME/repo/BasicIntegration.jl
    cd $HOME/repo/slock_rice
    sudo make clean install
    cd $HOME/repo/st_rice
    sudo make clean install
}


# setup themes
function themes_setup(){
    cd $HOME/repo/archSetup/res/themes
    sudo cp -r Nordic-v40/ Nordic-darker-v40/ Nordic-bluish-accent-v40/ /usr/share/themes
    sudo cp -r Nordzy-cursors/ Nordzy-cursors-white/ Zafiro-Icons-Dark/ Zafiro-Icons-Light/ candy-icons/ /usr/share/icons
    cd $HOME/repo/archSetup/res/themes/grub_theme
    sudo ./install.sh
}


function google_drive_setup(){
    mkdir -p $HOME/Document/google-drive
    cd $HOME/Document/google-drive
    grive -f
}


function virt_manager_set() {
    sudo aura -S qemu virt-manager ebtables libvirt lxsession
    sudo systemctl enable libvirtd
    sudo systemctl start libvirtd
    sudo usermod -G libvirt -a jacky
}


function configuration() {
    echo "###########################################"
    echo "###       basic packages install       ###"
    echo "###########################################"
    basic_packages_install()
    echo -e "\n\n"

    echo "###########################################"
    echo "###         AUR packages install        ###"
    echo "###########################################"
    AUR_packages_install()
    echo -e "\n\n"

    echo "###########################################"
    echo "###            dot file set             ###"
    echo "###########################################"
    dotfile_set()
    echo -e "\n\n"

    echo "###########################################"
    echo "###       additional_system_setup       ###"
    echo "###########################################"
    additional_system_setup()
    echo -e "\n\n"


    echo "###########################################"
    echo "###         documentation setup         ###"
    echo "###########################################"
    documentation_setup()
    echo -e "\n\n"

    echo "###########################################"
    echo "###          sound system setup         ###"
    echo "###########################################"
    sound_system_setup()
    echo -e "\n\n"

    echo "###########################################"
    echo "###           wall paper setup          ###"
    echo "###########################################"
    wallPaper_setup()
    echo -e "\n\n"

    echo "###########################################"
    echo "###          wifi driver setup          ###"
    echo "###########################################"
    wifiDrier_setup()
    echo -e "\n\n"

    echo "###########################################"
    echo "###        bluetooth driver setup       ###"
    echo "###########################################"
    bluetoothDiver_setup()
    echo -e "\n\n"

    echo "###########################################"
    echo "###             repo clone              ###"
    echo "###########################################"
    repo_clone()
    echo -e "\n\n"

    echo "###########################################"
    echo "###           themes setup              ###"
    echo "###########################################"
    themes_setup()
    echo -e "\n\n"

    echo "###########################################"
    echo "###         google_drive_setup          ###"
    echo "###########################################"
    google_drive_setup()
    echo -e "\n\n"
}
