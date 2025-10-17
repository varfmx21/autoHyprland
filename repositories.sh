#!/usr/bin/bash

# Created by varfmx21

#-----Colours-----#
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#-----Variables-----#
user=$(whoami)
pathRepos="$HOME/Desktop/$user/repos"

#-----Functions-----#
function ctrl_c() {
    echo -e "\n\n${redColour}[!] Quitting...${endColour}"
    exit 1
}

function banner() {

    echo -e "${purpleColour}                                     ___ ___                __    ";
    sleep 0.1
    echo -e "_______   ____ ______   ____  ______/   |   \\\\_____    ____ |  | __";
    sleep 0.1
    echo -e "\\\\_  __ \\\\_/ __ \\\\\\\\____ \\\\ /  _ \\\\/  ___/    ~    \\\\__  \\\\ _/ ___\\\\|  |/ /";
    sleep 0.1
    echo -e " |  | \\\\/\\\\  ___/|  |_> >  <_> )___ \\\\\\\\    Y    // __ \\\\\\\\  \\___|    < ";
    sleep 0.1
    echo -e " |__|    \\\\___  >   __/ \\\\____/____  >\\\\___|_  /(____  /\\\\___  >__|_ \\\\";
    sleep 0.1
    echo -e "             \\\\/|__|              \\\\/       \\\\/      \\\\/     \\\\/     \\\\/${endColour} ${grayColour}By${endColour} ${turquoiseColour}varfmx21${endColour}";
}

function AUR() {
    cd $pathRepos/paru-bin
    echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Downloading repo in $pathRepos${endColour}"
    sleep 1
    git clone https://aur.archlinux.org/paru-bin.git
    makepkg -si --noconfirm
    echo -e "\n\n${greenColour}[+]${endColour} ${grayColour}AUR installed in your ArchLinux${endColour}"
    sleep 1
}

function black_arch() {
    echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Installing BlackArch repos in Pacman...${endColour}"
    sleep 1
    mkdir -p $pathRepos/blackarch
    cd $pathRepos/blackarch
    echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Downloading repo in $pathRepos/blackarch${endColour}"
    sleep 1
    curl -O https://blackarch.org/strap.sh
    chmod +x ./strap.sh
    sudo ./strap.sh
    echo -e "\n\n${greenColour}[+]${endColour} ${grayColour}BlackArch repos installed in your Pacman${endColour}"
}

#-----Main-----#

trap ctrl_c INT

    banner


    printf "\n${yellowColour}[¿?]${endColour} You want to install AUR package? (y/n): " 
    read install_aur

    printf "\n${yellowColour}[¿?]${endColour} You want to install Black Arch packages? (y/n): " 
    read install_black

    echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Installing essentials packages for running this script...${endColour}"

    sudo pacman --noconfirm -Syu
    sudo pacman --noconfirm -S base-devel curl

    if [ ! -d $pathRepos ]; then
        echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour} Directory $pathRepos does not exist, creating...${endColour}"
        sleep 1
        mkdir -p $pathRepos
        echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Directory created${endColour}"
        sleep 1
    fi

    if [ "$install_aur" == "y" ]; then
        AUR
    fi
    
    if [ "$install_black" == "y" ]; then
        black_arch
    fi

echo -e "${yellowColour}Thanks for using!${endColour}"