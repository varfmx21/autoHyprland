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
user=$(whoami)
path=$(pwd)

#-----Functions-----#
function ctrl_c() {
    echo -e "\n\n${redColour}[!] Quitting...${endColour}"
    exit 1
}

function banner() {
    echo -e "\n${purpleColour} ▄▄▄       █    ██ ▄▄▄█████▓ ▒█████   ██░ ██▓██   ██▓ ██▓███   ██▀███   ██▓    ▄▄▄       ███▄    █ ▓█████▄ ";
    sleep 0.1
    echo -e "▒████▄     ██  ▓██▒▓  ██▒ ▓▒▒██▒  ██▒▓██░ ██▒▒██  ██▒▓██░  ██▒▓██ ▒ ██▒▓██▒   ▒████▄     ██ ▀█   █ ▒██▀ ██▌";
    sleep 0.1
    echo -e "▒██  ▀█▄  ▓██  ▒██░▒ ▓██░ ▒░▒██░  ██▒▒██▀▀██░ ▒██ ██░▓██░ ██▓▒▓██ ░▄█ ▒▒██░   ▒██  ▀█▄  ▓██  ▀█ ██▒░██   █▌";
    sleep 0.1
    echo -e "░██▄▄▄▄██ ▓▓█  ░██░░ ▓██▓ ░ ▒██   ██░░▓█ ░██  ░ ▐██▓░▒██▄█▓▒ ▒▒██▀▀█▄  ▒██░   ░██▄▄▄▄██ ▓██▒  ▐▌██▒░▓█▄   ▌";
    sleep 0.1
    echo -e " ▓█   ▓██▒▒▒█████▓   ▒██▒ ░ ░ ████▓▒░░▓█▒░██▓ ░ ██▒▓░▒██▒ ░  ░░██▓ ▒██▒░██████▒▓█   ▓██▒▒██░   ▓██░░▒████▓ ";
    sleep 0.1
    echo -e " ▒▒   ▓▒█░░▒▓▒ ▒ ▒   ▒ ░░   ░ ▒░▒░▒░  ▒ ░░▒░▒  ██▒▒▒ ▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░▓  ░▒▒   ▓▒█░░ ▒░   ▒ ▒  ▒▒▓  ▒ ";
    sleep 0.1
    echo -e "  ▒   ▒▒ ░░░▒░ ░ ░     ░      ░ ▒ ▒░  ▒ ░▒░ ░▓██ ░▒░ ░▒ ░       ░▒ ░ ▒░░ ░ ▒  ░ ▒   ▒▒ ░░ ░░   ░ ▒░ ░ ▒  ▒ ";
    sleep 0.1
    echo -e "  ░   ▒    ░░░ ░ ░   ░      ░ ░ ░ ▒   ░  ░░ ░▒ ▒ ░░  ░░         ░░   ░   ░ ░    ░   ▒      ░   ░ ░  ░ ░  ░ ";
    sleep 0.1
    echo -e "      ░  ░   ░                  ░ ░   ░  ░  ░░ ░                 ░         ░  ░     ░  ░         ░    ░    ";
    sleep 0.1
    echo -e "                                             ░ ░                                                    ░      ${endColour} ${grayColour}By${endColour} ${turquoiseColour}varfmx21${endColour}";
}

#-----Main-----#
if [ "$user" == "root" ]; then
    echo -e "\n${redColour}[!] Don't run as root this script${endColour}"
    echo -e "${redColour}[x] Quitting...${endColour}"
    exit 1
fi

banner

chmod +x "$path/distros/arch-linux.sh"
chmod +x "$path/distros/debian.sh"

echo -e "\n${greenColour}[+]${endColour} Selecting options for ${blueColour}${os}...${endColour}"
sleep 1
echo -e "\n${greenColour}[+]${endColour} Accessing to user ${purpleColour}$user${endColour} and ${purpleColour}root${endColour} for installation...."
sleep 1

printf "\n${yellowColour}[!]${endColour} This requires a ${redColour}fresh Linux environment${endColour} and ${redColour}AUR packages.${endColour} Are you sure to continue? (y/n): " 
read option

if [ "$option" == "n" ]; then
    echo -e "\n${redColour}[x]${endColour} Quitting script, see you!"
    exit 1
fi

echo -e "\n${greenColour}[+]${endColour} Starting installation..."
sleep 1

if [ "$os" == "archlinux" ]; then
    "$path/distros/arch-linux.sh"
elif [ "$os" == "ubuntu" ] || [ "$os" == "parrotos" ] || [ "$os" == "kalilinux" ]; then
    "$path/distros/debian.sh"
fi