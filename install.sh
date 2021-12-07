#!/bin/sh

##################################################
#		             Variables 			         #
##################################################

hostname="Arch"
root_password="km2217ob4b"
user_password="km2217ob4b"
time_zone="Asia/Taipei"


##################################################
#		             function 			         #
##################################################

# basic setup
function basic_setup() {
    # basic packages
    pacman -S linux-lts linux-lts-headers base-devel openssh networkmanager wpa_supplicant dialog lvm2 intel-ucode mesa nvidia-lts   

    # basic systemctl enable
    systemctl enable sshd
    systemctl enable NetworkManager

    # mkinitcpio
    echo "HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)" >> /etc/mkinitcpio.conf
    mkinitcpio -p linux-lts

    # locale
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    echo "zh_TW.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen

    # add root_password
    echo -en "$root_password\n$root_password" | passwd

    # add user_password
    echo -en "$user_password\n$user_password" | passwd "$user_name"
    cat > /etc/sudoers <<EOF
## sudoers file.
##
## This file MUST be edited with the 'visudo' command as root.
## Failure to use 'visudo' may result in syntax or file permission errors
## that prevent sudo from running.
##
## See the sudoers man page for the details on how to write a sudoers file.
##
##
## Host alias specification
##
## Groups of machines. These may include host names (optionally with wildcards),
## IP addresses, network numbers or netgroups.
# Host_Alias	WEBSERVERS = www1, www2, www3
##
## User alias specification
##
## Groups of users.  These may consist of user names, uids, Unix groups,
## or netgroups.
# User_Alias	ADMINS = millert, dowdy, mikef
##
## Cmnd alias specification
##
## Groups of commands.  Often used to group related commands together.
# Cmnd_Alias	PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, \
# 			    /usr/bin/pkill, /usr/bin/top
##
## Defaults specification
##
## You may wish to keep some of the following environment variables
## when running commands via sudo.
##
## Locale settings
# Defaults env_keep += "LANG LANGUAGE LINGUAS LC_* _XKB_CHARSET"
##
## Run X applications through sudo; HOME is used to find the
## .Xauthority file.  Note that other programs use HOME to find   
## configuration files and this may lead to privilege escalation!
# Defaults env_keep += "HOME"
##
## X11 resource path settings
# Defaults env_keep += "XAPPLRESDIR XFILESEARCHPATH XUSERFILESEARCHPATH"
##
## Desktop path settings
# Defaults env_keep += "QTDIR KDEDIR"
##
## Allow sudo-run commands to inherit the callers' ConsoleKit session
# Defaults env_keep += "XDG_SESSION_COOKIE"
##
## Uncomment to enable special input methods.  Care should be taken as
## this may allow users to subvert the command being run via sudo.
# Defaults env_keep += "XMODIFIERS GTK_IM_MODULE QT_IM_MODULE QT_IM_SWITCHER"
##
## Uncomment to enable logging of a command's output, except for
## sudoreplay and reboot.  Use sudoreplay to play back logged sessions.
# Defaults log_output
# Defaults!/usr/bin/sudoreplay !log_output
# Defaults!/usr/local/bin/sudoreplay !log_output
# Defaults!/sbin/reboot !log_output
##
## Runas alias specification
##
##
## User privilege specification
##
root ALL=(ALL) ALL
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL) ALL
## Same thing without a password
# %wheel ALL=(ALL) NOPASSWD: ALL
## Uncomment to allow members of group sudo to execute any command
# %sudo ALL=(ALL) ALL
## Uncomment to allow any user to run sudo if they know the password
## of the user they are running the command as (root by default).
# Defaults targetpw  # Ask for the password of the target user
# ALL ALL=(ALL) ALL  # WARNING: only use this together with 'Defaults targetpw'
%rfkill ALL=(ALL) NOPASSWD: /usr/sbin/rfkill
%network ALL=(ALL) NOPASSWD: /usr/bin/netcfg, /usr/bin/wifi-menu
## Read drop-in files from /etc/sudoers.d
## (the '#' here does not indicate a comment)
#includedir /etc/sudoers.d
EOF
    chmod 440 /etc/sudoers   

    # grub configuration
    pacman -S grub efibootmgr dosfstools os-prober mtools
    mkdir /boot/EFI
    mount /dev/sdb1 /boot/EFI
    grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
    grub-mkconfig -o /boot/grub/grub.cfg

    # set the time zone
    timedatectl set-timezone "$time_zone"
    systemctl enable systemd-timesyncd

    # set up host name
    hostnamectl set-hostname "$hostname"
    cat > /etc/hosts <<EOF
127.0.0.1 localhost
127.0.1.1 $hostname
EOF
}


# install package manager aura
function aura_install() {
    tar xvzf $HOME/repo/arch/source/aura-bin.tar.gz
    cd $HOME/repo/arch/aura-bin
    makepkg
    sudo pacman -U aura-bin-3.2.6-1-x86_64.pkg.tar.zst
}


# install packages
function packages_install() {
    sudo aura -S unzip stow gcin noto-fonts-emoji noto-fonts-cjk pandoc texlive-most texlive-lang pass gvim alsa-utils xclip npm wget python-pip man-db exa ninja tk tcl xmonad-contrib pulseaudio pulseaudio-bluetooth libnotify zathura-pdf-mupdf fzf zsh zsh-completions
    sudo aura -S alacritty qutebrowser neovim nitrogen ranger zathura calcurse mpv r xmonad mpd ncmpcpp pulsemixer dunst lxappearance qt5ct pcmanfm rofi
    sudo aura -A brave-bin polybar mutt-wizard abook miniconda3 qt5-webengine-widevine grive nvim-packer-git picom-jonaburg-git
    pip install ueberzug
}


# configure the dotfile
function dotfile_set() {
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
function wifiDrier_ser() {
    sudo aura -S dkms bc   # dependencies
    cd $HOME/repo/arch/driver/rtl8821ce_wifi_driver
    sudo ./dkms-install.sh
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
    git clone https://github.com/opottghjk00/dwm_rice.git
    cd $HOME/repo/slock_rice sudo make clean install
    cd $HOME/repo/st_rice
    sudo make clean install
}


# setup themes
function themes_set() {
    cd $HOME/repo/arch/source/themes
    sudo cp -r Nordic-v40/ Nordic-darker-v40/ Nordic-bluish-accent-v40/ /usr/share/themes
    sudo cp -r Nordzy-cursors/ Nordzy-cursors-white/ Zafiro-Icons-Dark/ Zafiro-Icons-Light/ candy-icons/ /usr/share/icons
}


function google-drive_set() {
    mkdir -p $HOME/Document/google-drive
    cd $HOME/Document/google-drive
    grive -f
}


function virt-manager_set() {
    sudo aura -S qemu virt-manager ebtables libvirt lxsession
    sudo systemctl enable libvirtd
    sudo systemctl start libvirtd
    sudo usermod -G libvirt -a jacky
}


#function nvim-dataScience-setup() {
#    nvim -jupyter notebook set
#    pip install jupyter_ascending
#    jupyter nbextension install --py --sys-prefix jupyter_ascending
#    jupyter nbextension     enable jupyter_ascending --sys-prefix --py
#    jupyter serverextension enable jupyter_ascending --sys-prefix --py
#}


function configuration() {
    echo "install the package manager aura"
    aura_install

    echo "install packages"
    packages_install

    echo "set up the dot file"
    dotfile_set

    echo "install wallpaper"
    wallPaper_set

    echo "set up the theme"
    themes_set

    echo "set up wifi card driver"
    wifiDrier_ser

    echo "set up bluetooth usb driver"
    bluetoothDiver_set

    echo "download the remote repo"
    repo_clone

    echo "clone the google cloud drive"
    google-drive_set
}


##################################################
#		           install process  	         #
##################################################

echo "basic setup..."
basic_setup

echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "further configuration..."
su jacky
configuration


echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "reboot..."
reboot
