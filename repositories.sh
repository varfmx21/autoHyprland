#!/usr/bin/bash

#-----Colours-----#
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#-----Variables-----#
user=$(whoami)

#-----Functions-----#
function ctrl_c() {
    echo -e "\n\n${redColour}[!] Quiting...${endColour}"
    exit 1
}

function banner() {
    echo -e "${purpleColour}                                          ___ ___                __    "
    sleep 0.1
    echo -e "     _______   ____ ______   ____  ______/   |   \_____    ____ |  | __"
    sleep 0.1
    echo -e "     \_  __ \_/ __ \\____  \ /  _ \/  ___/    ~    \__  \ _/ ___\|  |/ /"
    sleep 0.1
    echo -e "      |  | \/\  ___/|  |_> >  <_> )___ \     Y    // __ \   \___|    < "
    sleep 0.1
    echo -e "      |__|    \___  >   __/ \____/____  >\___|_  /(____  /\___  >__|_ \\"
    sleep 0.1
    echo -e "                  \/|__|              \/       \/      \/     \/     \/${endColour} ${grayColour}By${endColour} ${turquoiseColour}varfmx21${endColour}"
    sleep 0.1
}

#-----Main-----#
if [ $user == "root" ]; then
    echo -e "\n\n${redColour}[!] Don´t run as root this script${endColour}"
    echo -e "${redColour}[x] Quitiing...${endColour}"
    exit 1
else
    banner

    echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Installing AUR in archlinux...${endColour}"
    sleep 2

    if [ ! -d "~/Desktop/$user/repos" ]; then
        mkdir -p "~/Desktop/$user/repos"
    else
        cd ~/Desktop/$user/repos
        echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Downloading repo in ../home/$user/Desktop/$user/repos${endColour}"
        sleep 1
        git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin
        makepkg -si
        echo -e "\n\n${greenColour}[+]${endColour} ${grayColour}AUR installed in your ArchLinux${endColour}"

        echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Installing BlackArch repos in Pacman...${endColour}"
        cd ~/Desktop/$user/repos
        mkdir blackarch
        cd blackarch
        echo -e "\n\n${purpleColour}[+]${endColour} ${grayColour}Downloading repo in ../home/$user/Desktop/$user/repos/blackarch${endColour}"
        sleep 1
        curl -O https://blackarch.org/strap.sh
        chmod +x strap.sh
        sudo su
        ./strap.sh
        echo -e "\n\n${greenColour}[+]${endColour} ${grayColour}BlackArch repos installed in your Pacman${endColour}"
    fi
fi