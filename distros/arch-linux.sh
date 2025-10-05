#!/usr/bin/bash

#-----Variables-----#
user=$(whoami)
path="$(pwd)"

#-----Colours-----#
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#-----Main-----#
echo -e "\n${greenColour}[+]${endColour} First, we need to upgrade the system"
sleep 1
sudo pacman -Syu

echo -e "\n${greenColour}[+]${endColour} Installing packages for the environment"
sudo pacman -S 7zip kitty zsh zsh-autosuggestions zsh-syntax-highlighting bat lsd fzf hyprland wofi waybar thunar hyprshot swaync hyprlock hyprpaper

# Hack Nerd Font
echo -e "\n${greenColour}[+]${endColour} Installing Hack Nerd Font..."
sleep 1
sudo mkdir -p "/usr/local/share/fonts"
cd /usr/local/share/fonts
sudo curl -L  --progress-bar https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip -o ./Hack.zip
if [ $? -eq 0 ]; then
    sudo 7z x ./Hack.zip
    sudo rm ./Hack.zip ./LICENSE.md ./README.md
    echo -e "\n ${greenColour}[+]]${endColour} Hack Nerd Font installed successfully"
else
    echo -e "\n ${redColour}[!]${endColour} Failed to download Hack Nerd Font"
fi

# Kitty
echo -e "\n${greenColour}[+]${endColour} Configurating kitty terminal for $user..."
sleep 1
mkdir -p ~/.config/kitty
cd ~/.config/kitty
cp "$path/config/kitty/kitty.conf" .
cp "$path/config/kitty/color.ini" .
echo -e "\n${greenColour}[+]${endColour} Configurating kitty terminal for root..."
sudo mkdir -p /root/.config/kitty
sudo cp -r /home/$user/.config/kitty/* /root/.config/kitty/
echo -e "\n ${greenColour}[+]]${endColour} Configuration installed successfully"
sleep 20

# ZSH
sudo usermod --shell /usr/bin/zsh "$user"
sudo usermod --shell /usr/bin/zsh root

cd "$HOME"
touch .zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
cp $path/config/zsh/.p10k.zsh $HOME

sudo su
cd /root
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
cp $path/config/zsh/.p10k.zsh1 /root
mv /root/.p10k.zsh1 /root/.p10k.zsh
ln -s -f /home/$user/.zshrc .zshrc
exit

cd /usr/share
mkdir zsh-sudo
cd zsh-sudo
mv $path/config/zsh/sudo.plugin.zsh .

# Funciones s4vitar
mkdir -p ~/.config/bin
cd ~/.config/bin
touch target

# Hypr

mkdir -p ~/.config/backgrounds
mv $path/wallpapers/* ~/.config/backgrounds