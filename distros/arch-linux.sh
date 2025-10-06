#!/usr/bin/bash

#-----Variables-----#
user=$(whoami)
path="$(pwd)"
pathRepos="$HOME/Desktop/$user/repos"

#-----Colours-----#
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Options for system
printf "\n${yellowColour}[¿?]${endColour} Which wallpaper manager do you choose? GIFs or static (swww=1, hyprpaper=2): " 
read wallpaper_manager
if [ "$wallpaper_manager" -eq "1" ]; then
    printf "\n${yellowColour}[¿?]${endColour} Which wallpaper you choose? (1, 2): "
    read wallpaper_file
elif [ "$wallpaper_manager" -eq "2" ]; then
    printf "\n${yellowColour}[¿?]${endColour} Which wallpaper you choose? (1, 2, 3): "
    read wallpaper_file
else
    echo -e "\n${redColour}[x]${endColour} Press a valid option"
    exit 1
fi

# System Upgrade
echo -e "\n${greenColour}[+]${endColour} First, we need to upgrade the system"
sleep 1
sudo pacman -Syu

# Packages install
echo -e "\n${greenColour}[+]${endColour} Installing packages for the environment"
if [ $wallpaper_manager == 1 ]; then
    sudo pacman -S --noconfirm 7zip kitty zsh zsh-autosuggestions zsh-syntax-highlighting bat lsd fzf hyprland wofi waybar thunar hyprshot swaync hyprlock swww ly spotify-launcher brightnessctl
elif [ $wallpaper_manager == 2 ]; then
    sudo pacman -S --noconfirm 7zip kitty zsh zsh-autosuggestions zsh-syntax-highlighting bat lsd fzf hyprland wofi waybar thunar hyprshot swaync hyprlock hyprpaper ly spotify-launcher brightnessctl
fi

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
sudo ln -s -f /home/$user/.zshrc /root/.zshrc

echo -e "\n${greenColour}[+]${endColour} Installing sudo zsh plugin..."
sudo mkdir -p /usr/share/zsh/plugins/zsh-sudo
sudo curl -L  --progress-bar https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/sudo/sudo.plugin.zsh -o /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
if [ $? -eq 0 ]; then
    echo -e "\n ${greenColour}[+]${endColour} Sudo zsh plugin installed successfully"
else
    echo -e "\n ${redColour}[!]${endColour} Failed to download sudo zsh plugin"
fi

# Hyprland
echo -e "\n${greenColour}[+]${endColour} Configurating hyprland..."

mkdir -p ~/.config/hypr
cp -r $path/config/hypr/* ~/.config/hypr/

mkdir -p ~/.config/backgrounds
cp $path/wallpapers/* ~/.config/backgrounds

if [ "$wallpaper_manager" -eq "1" ]; then
    if [ "$wallpaper_file" -eq "1" ]; then
        sed -i '/exec-once = waybar & swaync & hyprpaper/a\
exec-once = swww-daemon\
exec-once = sleep 1 && swww img ~/.config/backgrounds/wallpaper_1.gif' ~/.config/hypr/hyprland.conf
    else
        sed -i '/exec-once = waybar & swaync & hyprpaper/a\
exec-once = swww-daemon\
exec-once = sleep 1 && swww img ~/.config/backgrounds/wallpaper_2.gif' ~/.config/hypr/hyprland.conf
    fi
elif [ "$wallpaper_manager" -eq "2" ]; then
    if [ "$wallpaper_file" -eq "1" ]; then
        echo "preload = ~/.config/backgrounds/wallpaper_1.jpg" >> ~/.config/hypr/hyprpaper.conf
        echo "wallpaper = , ~/.config/backgrounds/wallpaper_1.jpg" >> ~/.config/hypr/hyprpaper.conf
    elif [ "$wallpaper_file" -eq "2" ]; then
        echo "preload = ~/.config/backgrounds/wallpaper_2.png" >> ~/.config/hypr/hyprpaper.conf
        echo "wallpaper = , ~/.config/backgrounds/wallpaper_2.png" >> ~/.config/hypr/hyprpaper.conf
    else
        echo "preload = ~/.config/backgrounds/wallpaper_3.jpg" >> ~/.config/hypr/hyprpaper.conf
        echo "wallpaper = , ~/.config/backgrounds/wallpaper_3.jpg" >> ~/.config/hypr/hyprpaper.conf
    fi
fi

mkdir -p ~/.config/waybar
cp -r $path/config/waybar/* ~/.config/waybar/
cp -r $path/lib/* ~/.config/waybar/

mkdir -p ~/.config/wofi
cp -r $path/config/wofi/* ~/.config/wofi/

# Ly
echo -e "\n${greenColour}[+]${endColour} Enabling ly display manager..."
sudo systemctl enable ly.service

echo -e "\n${greenColour}[+]${endColour} Installation complete!"
printf "\n${yellowColour}[]${endColour} You want to reboot now? (y/n): " 
read reboot

if [ "$reboot" == "y" ]; then
    sudo reboot now
else
    exit 0
fi