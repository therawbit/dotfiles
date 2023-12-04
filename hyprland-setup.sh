#!/bin/bash

function ricing_dependency(){
	sudo pacman -S ttf-jetbrains-mono --noconfirm
	sudo pacman -S ttf-jetbrains-mono-nerd --noconfirm
	sudo pacman -S playerctl --noconfirm
	sudo pacman -S hyprland --noconfirm
	sudo pacman -S flameshot --noconfirm
	sudo pacman -S waybar --noconfirm
	sudo pacman -S dunst --noconfirm
	sudo pacman -S sddm --noconfirm
	sudo pacman -S alacritty --noconfirm
	sudo pacman -S hyprpaper --noconfirm
	sudo pacman -S rofi --noconfirm
	sudo pacman -S pulseaudio --noconfirm
	sudo pacman -S brightnessctl --noconfirm
	sudo pacman -S inotify-tools --noconfirm
}

function basic_apps(){
	sudo pacman -S nautilus --noconfirm
	sudo pacman -S gnome-disk-utility --noconfirm
	sudo pacman -S vlc --noconfirm
	sudo pacman -S gnome-keyring --noconfirm
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
	sudo pacman -S cliphist --noconfirm

}

function nautilus_terminal(){
	mkdir -p ~/.local/share/nautilus/scripts
	mkdir -p ~/.config/nautilus
	echo '#!/bin/bash ' > ~/.local/share/nautilus/scripts/Terminal
	echo 'alacritty' >> ~/.local/share/nautilus/scripts/Terminal

	chmod +x ~/.local/share/nautilus/scripts/Terminal

	echo '<Super>T Terminal' > ~/.config/nautilus/scripts-accels

}

ricing_dependency
basic_apps
nautilus_terminal

