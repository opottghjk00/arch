#!/bin/sh


##################################################################
#		                      function 			                 #
##################################################################

# basic packages install
function basic_packages_install(){
    sudo pacman -S linux-lts-headers base-devel gcin noto-fonts-emoji noto-fonts-cjk dkms bc
    sudo pacman -S xorg-xinit xorg-xsetroot xorg-server imlib2 xorg-xrandr btop ranger gimp mpd
    sudo pacman -S zsh zsh-completions pass unzip neofetch maim picom firefox
    sudo pacman -S xclip npm wget man-db exa ninja tk tcl xmonad-contrib libnotify fzf
    sudo pacman -S alacritty nitrogen xmonad dunst lxappearance pcmanfm rofi starship
    #additional application
    sudo pacman -S obs-studio r obsidian
}


# install AUR helper
function AUR_packages_install(){
    [[ ! -d $HOME/document ]] && mkdir $HOME/document
    mkdir -p $HOME/document/open_source
    git clone https://aur.archlinux.org/yay.git $HOME/document/open_source/yay
    cd $HOME/document/open_source/yay
    makepkg -si
    ###########################################"
    ###         install julia-bin           ###"
    ###########################################"
    yay -S julia-bin
    ###########################################"
    ###            install grive            ###"
    ###########################################"
    yay -S grive
    ###########################################"
    ###            install polybar          ###"
    ###########################################"
    yay -S polybar
    ###########################################"
    ###      install st glyph support       ###"
    ###########################################"
    yay -S libxft-bgra
}


# configure the dotfile
function dotfile_set(){
    sudo pacman -S stow
    [[ ! -d $HOME/.config ]] && mkdir $HOME/.config
    [[ ! -d $HOME/.local ]] && mkdir $HOME/.local
    mkdir -p $HOME/.local/bin $HOME/.local/share
    git clone https://github.com/opottghjk00/dotx.git $HOME/dotx
    cd $HOME/dotx/local/.local/bin
    chmod u+x *
    cd $HOME/dotx/ranger/.config/ranger
    chmod u+x scope.sh
    cd $HOME/dotx/polybar/.config/polybar
    chmod u+x install.sh
    cd $HOME/dotx/polybar/.config/polybar/weather
    chmod u+x weather.sh
    cd $HOME/dotx
    stow */ 
    cd $HOME/dotx/ranger/.config/ranger/plugins/ranger_devicons
    git submodule init
    git submodule update
}


function pass_setup(){
    [[ ! -d $HOME/.local/share ]] && mkdir $HOME/.local/share
    git clone https://github.com/githubjacky/password-store.git $HOME/.local/share/password-store
}

function additional_system_setup(){
    chsh -s /bin/zsh  # change the default shell
    sudo cp $HOME/repo/archSetup/res/utils/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf  # enable tap click
    # tlp auto-cpufreq set up
    cd $HOME/repo/archSetup/res/BetterBattery
    chmod u+x jumpstart.sh
    sudo ./jumpstart.sh
    git config --global credential.helper store
    # python packages
    pip install ueberzug pipenv
    # julia packages
    
}

# setup documentation work
function documentation_setup(){
    sudo pacman -S gvim zathura evince pandoc texlive-most texlive-lang zathura-pdf-mupdf
    cd $HOME/document/open_source/
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout release-0.7
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    git clone https://github.com/opottghjk00/nvimIDE.git $HOME/repo/nvimIDE
    ln -s $HOME/repo/nvimIDE $HOME/.config/nvim
}


# setup sound system
function sound_system_setup(){
    sudo pacman -S mpv mpd pulsemixer ncmpcpp youtube-dl
    sudo systemctl enable mpd
    sudo systemctl start mpd
}


# wallpaper
function wallPaper_setup(){
    mkdir -p $HOME/document/picture
    ln -s $HOME/repo/archSetup/res/wallPaper ~/document/picture/wallPaper
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
    git clone https://github.com/githubjacky/slock_rice.git $HOME/repo/slock_rice
    git clone https://github.com/githubjacky/st_rice.git $HOME/repo/st_rice
    git clone https://github.com/githubjacky/leet_code_practice.git $HOME/repo/leet_code_practice
    git clone https://github.com/githubjacky/ptt_crawler.git $HOME/repo/ptt_crawler
    git clone https://github.com/githubjacky/SFrontiers.jl.git $HOME/repo/SFrontiers.jl
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


##################################################################
#		             additional setup 		         #
##################################################################
function google_drive_setup(){
    mkdir -p $HOME/document/googleDrive/ntu
    cd $HOME/document/googleDrive/ntu
    grive -a
    mkdir -p $HOME/document/googleDrive/opo
    cd $HOME/document/googleDrive/opo
    grive -a
}


function virt_manager_set() {
    LC_ALL=C.UTF-8 lscpu | grep Virtualization
    yay -S qemu virt-manager ebtables libvirt lxsession
    sudo systemctl enable libvirtd
    sudo systemctl start libvirtd
    sudo usermod -G libvirt -a jacky
}


##################################################################
#		             install process 		         #
##################################################################
echo "###########################################"
echo "###       basic packages install       ###"
echo "###########################################"
basic_packages_install
echo -e "\n\n"

echo "###########################################"
echo "###         AUR packages install        ###"
echo "###########################################"
AUR_packages_install
echo -e "\n\n"

echo "###########################################"
echo "###            dot file set             ###"
echo "###########################################"
dotfile_set
echo -e "\n\n"

echo "###########################################"
echo "###       additional_system_setup       ###"
echo "###########################################"
additional_system_setup
echo -e "\n\n"

echo "###########################################"
echo "###        password store setup         ###"
echo "###########################################"
pass_setup
echo -e "\n\n"

echo "###########################################"
echo "###         documentation setup         ###"
echo "###########################################"
documentation_setup
echo -e "\n\n"

echo "###########################################"
echo "###          sound system setup         ###"
echo "###########################################"
sound_system_setup
echo -e "\n\n"

echo "###########################################"
echo "###           wall paper setup          ###"
echo "###########################################"
wallPaper_setup
echo -e "\n\n"

echo "###########################################"
echo "###          wifi driver setup          ###"
echo "###########################################"
wifiDrier_setup
echo -e "\n\n"

echo "###########################################"
echo "###        bluetooth driver setup       ###"
echo "###########################################"
bluetoothDiver_setup
echo -e "\n\n"

echo "###########################################"
echo "###             repo clone              ###"
echo "###########################################"
repo_clone
echo -e "\n\n"

echo "###########################################"
echo "###           themes setup              ###"
echo "###########################################"
themes_setup
echo -e "\n\n"
