#!/bin/bash


function ricing_dependency(){
	sudo pacman -S ttf-jetbrains-mono --noconfirm
	sudo pacman -S ttf-jetbrains-mono-nerd --noconfirm
	sudo pacman -S playerctl --noconfirm
	sudo pacman -S pamixer --noconfirm
	sudo pacman -S flameshot --noconfirm
	sudo pacman -S polybar --noconfirm
	sudo pacman -S dunst --noconfirm
	sudo pacman -S picom --noconfirm
	sudo pacman -S alacritty --noconfirm
	sudo pacman -S rofi --noconfirm
	sudo pacman -S feh --noconfirm
	sudo pacman -S pulseaudio --noconfirm
	sudo pacman -S xss-lock --noconfirm
	sudo pacman -S xfce4-power-manager --noconfirm
	sudo pacman -S brightnessctl --noconfirm
}


function basic_apps(){
	sudo pacman -S nautilus --noconfirm
	sudo pacman -S gnome-disk-utility --noconfirm
	sudo pacman -S vlc --noconfirm
	sudo pacman -S python-pip --noconfirm
	sudo pacman -S discord --noconfirm
	sudo pacman -S telegram-desktop --noconfirm
	sudo pacman -S code --noconfirm
	sudo pacman -S eog --noconfirm
	sudo pacman -S evince --noconfirm
	sudo pacman -S jdk21-openjdk --noconfirm
	sudo pacman -S docker --noconfirm
	sudo pacman -S obsidian --noconfirm
	sudo pacman -S firefox --noconfirm
	sudo pacman -S brave-browser --noconfirm
	sudo pacman -S docker-compose --noconfirm
	sudo pacman -S zsh --noconfirm

}
function setup_rice(){
    cd ~/.config/
    git clone https://github.com/Sudru/dotfiles.git

    for file in $(ls -d dotfiles/*/)
    do
        f=$(echo $file | cut -d '/' -f 2)
        ln -s $file $f
    done
}

function remove_unwanted(){
	sudo pacman -R viewnior --noconfirm
	sudo pacman -R pcmanfm --noconfirm
	sudo pacman -R xterm --noconfirm
	sudo pacman -R epdfview --noconfirm
	sudo pacman -R mousepad --noconfirm
	sudo pacman -R palemoon-bin --noconfirm
}

function nautilus_terminal(){
	mkdir -p ~/.local/share/nautilus/scripts
	mkdir -p ~/.config/nautilus
	echo '#!/bin/bash ' > ~/.local/share/nautilus/scripts/Terminal
	echo 'alacritty' >> ~/.local/share/nautilus/scripts/Terminal

	chmod +x ~/.local/share/nautilus/scripts/Terminal

	echo '<Super>T Terminal' > ~/.config/nautilus/scripts-accels

}

# sudo pacman-mirrors --fasttrack 20  && sudo pacman -Syyu 
ricing_dependency
setup_rice
basic_apps
remove_unwanted
nautilus_terminal
# gsettings set org.gnome.desktop.interface color-scheme prefer-dark

#export GTK_THEME=Graphite-Dark