#!/usr/bin/bash

#-----Variables-----#
user=$(whoami)
path="$(pwd)"

#-----Colours-----#
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"

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

printf "\n${yellowColour}[¿?]${endColour} You want to install AUR packages? (y/n): " 
read install_aur
if [ "$install_aur" == "y" ]; then
    if ! command -v paru &>/dev/null; then
        echo -e "${yellowColour}[!]${endColour} Paru not found, installing..."
        chmod +x ./$path/setup.sh
        ./$path/setup.sh
    fi
fi

# System Upgrade
echo -e "\n${greenColour}[+]${endColour} First, we need to upgrade the system"
sleep 1
sudo pacman -Syu --noconfirm

# Packages install
echo -e "\n${greenColour}[+]${endColour} Installing packages for the environment"
if [ $wallpaper_manager == 1 ]; then
    sudo pacman -S --noconfirm 7zip kitty zsh zsh-autosuggestions zsh-syntax-highlighting bat lsd fzf hyprland wofi waybar thunar hyprshot swaync hyprlock swww ly spotify-launcher brightnessctl fastfetch vlc rofi sof-firmware pipewire pipewire-pulse
elif [ $wallpaper_manager == 2 ]; then
    sudo pacman -S --noconfirm 7zip kitty zsh zsh-autosuggestions zsh-syntax-highlighting bat lsd fzf hyprland wofi waybar thunar hyprshot swaync hyprlock hyprpaper ly spotify-launcher brightnessctl fastfetch vlc rofi sof-firmware pipewire pipewire-pulse
fi

if [ "$install_aur" == "y" ]; then
    paru -S --noconfirm brave-bin
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
cp -r $path/config/kitty/* ~/.config/kitty
echo -e "\n${greenColour}[+]${endColour} Configurating kitty terminal for root..."
sudo mkdir -p /root/.config/kitty
sudo cp -r /home/$user/.config/kitty/* /root/.config/kitty/
echo -e "\n ${greenColour}[+]${endColour} Configuration of kitty installed successfully"

# ZSH
echo -e "\n${greenColour}[+]${endColour} Configurating ZSH configuration..."
sudo usermod --shell /usr/bin/zsh "$user"
sudo usermod --shell /usr/bin/zsh root

mkdir -p ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k/
cp $path/config/zsh/.p10k.zsh ~/
cp $path/config/zsh/.zshrc ~/

sudo mkdir -p /root/powerlevel10k
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k/
sudo ln -s -f /home/$user/.zshrc /root/.zshrc
cp $path/config/zsh/.p10k_root.zsh /root/
mv /root/.p10k_root.zsh /root/.p10k.zsh

echo -e "\n${greenColour}[+]${endColour} Installing sudo zsh plugin..."
sudo mkdir -p /usr/share/zsh/plugins/zsh-sudo
sudo curl -L  --progress-bar https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/sudo/sudo.plugin.zsh -o /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
if [ $? -eq 0 ]; then
    echo -e "\n ${greenColour}[+]${endColour} Sudo zsh plugin installed successfully"
else
    echo -e "\n ${redColour}[!]${endColour} Failed to download sudo zsh plugin"
fi
echo -e "\n ${greenColour}[+]${endColour} Configuration of zsh installed successfully"

# Hyprland
echo -e "\n${greenColour}[+]${endColour} Configurating hyprland..."

mkdir -p ~/.config/hypr
cp -r $path/config/hypr/* ~/.config/hypr/

mkdir -p ~/.config/backgrounds
cp $path/wallpapers/* ~/.config/backgrounds

if [ "$wallpaper_manager" == "1" ]; then
    if [ "$wallpaper_file" == "1" ]; then
        sed -i '/exec-once = waybar & swaync & hyprpaper/a\
exec-once = swww-daemon\
exec-once = sleep 1 && swww img ~/.config/backgrounds/wallpaper_1.gif' ~/.config/hypr/hyprland.conf
    else
        sed -i '/exec-once = waybar & swaync & hyprpaper/a\
exec-once = swww-daemon\
exec-once = sleep 1 && swww img ~/.config/backgrounds/wallpaper_2.gif' ~/.config/hypr/hyprland.conf
    fi
elif [ "$wallpaper_manager" == "2" ]; then
    if [ "$wallpaper_file" == "1" ]; then
        echo "preload = ~/.config/backgrounds/wallpaper_1.jpg" > ~/.config/hypr/hyprpaper.conf
        echo "wallpaper = , ~/.config/backgrounds/wallpaper_1.jpg" >> ~/.config/hypr/hyprpaper.conf
    elif [ "$wallpaper_file" == "2" ]; then
        echo "preload = ~/.config/backgrounds/wallpaper_2.png" > ~/.config/hypr/hyprpaper.conf
        echo "wallpaper = , ~/.config/backgrounds/wallpaper_2.png" >> ~/.config/hypr/hyprpaper.conf
    else
        echo "preload = ~/.config/backgrounds/wallpaper_3.jpg" > ~/.config/hypr/hyprpaper.conf
        echo "wallpaper = , ~/.config/backgrounds/wallpaper_3.jpg" >> ~/.config/hypr/hyprpaper.conf
    fi
fi

mkdir -p ~/.config/waybar
mkdir -p ~/.config/waybar/scripts
cp -r $path/config/waybar/* ~/.config/waybar/
cp -r $path/lib/* ~/.config/waybar/scripts/

chmod +x ~/.config/waybar/scripts/ethernet_status.sh
chmod +x ~/.config/waybar/scripts/showFastFetch.sh
chmod +x ~/.config/waybar/scripts/target_to_hack.sh
chmod +x ~/.config/waybar/scripts/vpn_status.sh

mkdir -p ~/.config/wofi
cp -r $path/config/wofi/* ~/.config/wofi/
echo -e "\n ${greenColour}[+]${endColour} Configuration of hyprland installed successfully"

# Ly
echo -e "\n${greenColour}[+]${endColour} Enabling ly display manager..."
sudo systemctl enable ly.service

echo -e "\n${greenColour}[+]${endColour} Installation complete!"
printf "\n${yellowColour}[¿?]${endColour} You want to reboot now? (y/n): " 
read reboot

echo -e "${yellowColour}Thanks for using this script!{endColour}"

if [ "$reboot" == "y" ]; then
    sudo reboot now
else
    exit 0
fi