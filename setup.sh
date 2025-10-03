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
os=$(cat /etc/os-release | sed -nE "s/^[[:space:]]*NAME[[:space:]]*=[[:space:]]*(['\"]?)(.*)\1[[:space:]]*$/\2/p" | awk '{print tolower($0)}' | tr -d ' ')
usr=$(whoami)
path=$(pwd)

#-----Functions-----#
function ctrl_c() {
    echo -e "\n\n${redColour}[!] Quitting...${endColour}"
    exit 1
}

function banner() {
    echo -e "\n${purpleColour}                    __           ___ ___                      .__                     .___"
    sleep 0.1
    echo -e "     _____   __ ___/  |_  ____  /   |   \ ___.__._____________|  | _____    ____    __| _/"
    sleep 0.1
    echo -e "     \__  \ |  |  \   __\/  _ \/    ~    <   |  |\____ \_  __ \  | \__  \  /    \  / __ | "
    sleep 0.1
    echo -e "      / __ \|  |  /|  | (  <_> )    Y    /\___  ||  |_> >  | \/  |__/ __ \|   |  \/ /_/ | "
    sleep 0.1
    echo -e "     (____  /____/ |__|  \____/ \___|_  / / ____||   __/|__|  |____(____  /___|  /\____ | "
    sleep 0.1
    echo -e "          \/                          \/  \/     |__|                   \/     \/      \/ ${endColour} ${grayColour}By${endColour} ${turquoiseColour}varfmx21${endColour}"
}

#-----Main-----#
if [ "$user" == "root" ]; then
    echo -e "\n${redColour}[!] Don't run as root this script${endColour}"
    echo -e "${redColour}[x] Quitting...${endColour}"
    exit 1
fi

banner

chmod +x "$path/arch-linux.sh"
chmod +x "$path/debian.sh"

echo -e "\n${greenColour}[+]${endColour} Selecting options for ${yellowColour}${os}...${endColour}"
sleep 1
echo -e "\n${greenColour}[+]${endColour} Accessing to user $usr and root for installation...."
sleep 1
echo -e "\n${greenColour}[+]${endColour} Starting installation..."

if [ "$os" == "archlinux" ]; then
    ./arch-linux.sh
elif [ "$os" == "ubuntu" ] || [ "$os" == "parrotos" ] || [ "$os" == "kalilinux" ]; then
    ./debian.sh
fi