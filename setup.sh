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
if [ $user == "root" ]; then
    echo -e "\n\n${redColour}[!] Don´t run as root this script${endColour}"
    echo -e "${redColour}[x] Quitiing...${endColour}"
    exit 1
else
    banner
    echo -e "\n\n${yellowColour}[?]${endColour} ${grayColour}Which Wallpaper you want to configure? (1/2)${endColour}"
    read -p " ${grayClour}Option: ${endColour}" pathWallpaper
    sleep 1

    echo -e "\n${purpleColour}[+]${endColour} ${grayColour}Downloading packages...${endColour}"
    sleep 2
fi