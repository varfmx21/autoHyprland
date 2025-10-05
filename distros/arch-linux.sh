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
    echo -e "\n ${greenColour}[+]${endColour} Hack Nerd Font installed successfully"
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
echo -e "\n ${greenColour}[+]${endColour} Configuration installed successfully"

# ZSH
echo -e "\n${greenColour}[+]${endColour} Configurating ZSH configuration..."
sudo usermod --shell /usr/bin/zsh "$user"
sudo usermod --shell /usr/bin/zsh root

cd ~/
mkdir -p ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k/
cp $path/config/zsh/.p10k.zsh ~/
cp $path/config/zsh/.zshrc ~/

sudo mkdir -p /root/powerlevel10k
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k/
cp $path/config/zsh/.p10k.zsh1 /root/
sudo mv /root/.p10k.zsh-root /root/.p10k.zsh
sudo ln -s -f /home/$user/.zshrc /root/.zshrc

echo -e "\n${greenColour}[+]${endColour} Installing sudo zsh plugin..."
sudo mkdir -p /usr/share/zsh/plugins/zsh-sudo
sudo curl -L  --progress-bar https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/sudo/sudo.plugin.zsh -o /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
if [ $? -eq 0 ]; then
    echo -e "\n ${greenColour}[+]${endColour} Sudo zsh plugin installed successfully"
else
    echo -e "\n ${redColour}[!]${endColour} Failed to download sudo zsh plugin"
fi

# Funciones s4vitar
mkdir -p ~/.config/bin
cd ~/.config/bin
touch target

# Hypr

mkdir -p ~/.config/backgrounds
mv $path/wallpapers/* ~/.config/backgrounds