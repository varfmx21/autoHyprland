#-----Variables-----#
user=$(whoami)
dir="$(pwd)"

# Dependecias = {zsh, kitty}
sudo pacman -S kitty zsh zsh-autosuggestions zsh-syntax-highlighting bat

# Hack Nerd Font
echo -e "\n${greenColour}[+]${endColour} Installing Hack Nerd Font..."
sudo mkdir -p "/usr/local/share/fonts"
cd /usr/local/share/fonts
curl -L  --progress-bar https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip -o ./Hack.zip
if [ $? -eq 0 ]; then
    7z x /usr/local/share/fonts/Hack.zip
    rm /usr/local/share/fonts/Hack.zip
    echo -e "\n ${greenColour}[+]]${endColour} Hack Nerd Font installed successfully"
else
    echo -e "\n ${redColour}[!]${endColour} Failed to download Hack Nerd Font"
fi

# Kitty
mkdir -p ~/.config/kitty
cd ~/.config/kitty
cp "$dir/config/kitty/kitty.conf" .
cp "$dir/config/kitty/color.ini" .
mkdir -p /root/.config/kitty
sudo cd /root/.config/kitty
cp "/home/$user/.config/kitty/*" .


# ZSH
sudo usermod --shell /usr/bin/zsh "$user"
sudo usermod --shell /usr/bin/zsh root

cd "$HOME"
touch .zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
cp $dir/config/zsh/.p10k.zsh $HOME

sudo su
cd /root
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
cp $dir/config/zsh/.p10k.zsh1 /root
mv /root/.p10k.zsh1 /root/.p10k.zsh
ln -s -f /home/$user/.zshrc .zshrc
exit

cd /usr/share
mkdir zsh-sudo
cd zsh-sudo
mv $dir/config/zsh/sudo.plugin.zsh .