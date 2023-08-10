#!/bin/bash



# Define colors...
RED=`tput bold && tput setaf 1`
YELLOW=`tput bold && tput setaf 3`
NC=`tput sgr0`

function RED(){
	echo -e "\n${RED}${1}${NC}"
}

function YELLOW(){
	echo -e "\n${YELLOW}${1}${NC}"
}



function base_install(){
	while [ $(sudo snap list | awk '(NR>1) {print $1}' | wc -l) -gt 0 ]
	do
		for program in $(sudo snap list | awk '(NR>1) {print $1}') 
		do
		sudo snap remove --purge $program 2>/dev/null
		done
	done
	#sudo apt-mark hold snapd
	sudo apt autoremove --purge snapd -y
	sudo rm -rf /var/cache/snapd/
	sudo apt autoremove --purge snapd gnome-software-plugin-snap -y
	sudo rm -fr ~/snap
	echo Snap removed completely
		
#update and upgrade
	YELLOW "Updating the system..."
	sudo apt update 
	sudo apt upgrade -y


	YELLOW "Installing Git.."
	sudo apt install -y git

	YELLOW "Installing curl "
	sudo apt install -y curl 



	YELLOW "Installing python pip.."
	sudo apt install python3-pip -y



	YELLOW "Installing Default JDK.."
	sudo apt install default-jdk -y


	YELLOW "Installing Openvpn.."
	sudo apt install -y openvpn
	


	
	YELLOW "Installing deb-get"
	curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get

	YELLOW "Removing the ubuntu-dock"
	sudo apt autoremove gnome-shell-extension-ubuntu-dock -y

	YELLOW "Installing Pytube"
	pip3 install pytube

	YELLOW "Installing Transmission"
	sudo apt install transmission -y
	
	YELLOW "Installing vlc"
	sudo apt install vlc -y

	YELLOW "Installing sublime text"
	sudo deb-get install sublime-text

	YELLOW "Installing VS code"
	sudo deb-get install code

	YELLOW "Installing Brave"
	sudo deb-get install brave-browser

	YELLOW "Installing Chrome"
	#sudo deb-get install google-chrome-stable

	YELLOW "Installing Telegram"
	sudo apt install telegram-desktop -y

	YELLOW "Installing Discord"
	sudo deb-get install discord
	
	YELLOW "Installing gnome-tweaks"
	sudo apt install gnome-tweaks -y


	#firefox deb
	YELLOW "Installing Firefox Deb"
	sudo add-apt-repository ppa:mozillateam/ppa
	echo '
	Package: firefox*
	Pin: release o=LP-PPA-mozillateam
	Pin-Priority: 1001
	' | sudo tee /etc/apt/preferences.d/mozilla-firefox

	echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

	sudo apt install firefox

	#terminal nautilus
	YELLOW "Setting Up Gnome Terminal for Nautilus"

	echo '#!/bin/bash ' > ~/.local/share/nautilus/scripts/Terminal
	echo 'gnome-terminal' >> ~/.local/share/nautilus/scripts/Terminal
	chmod +x ~/.local/share/nautilus/scripts/Terminal
	echo '<Super>T Terminal' > ~/.config/nautilus/scripts-accels



}	

#Tools Installation
function install_tools(){

	#sqlite

	YELLOW "Installing sqlite..."
	#sudo apt install -y sqlite	

	#unrar
	YELLOW "Installing unrar..."
	sudo apt install -y unrar

	#steghide
	YELLOW "Installing steghide..."
	sudo apt install -y steghide


	#binwalk
	YELLOW "Installing Binwalk..."
	sudo apt install -y binwalk

	#hexedit
	YELLOW "Installing hexedit..."
	sudo apt install -y hexedit	

	#exiftool
	YELLOW "Installing exiftool..."
	sudo apt-get install -y exiftool

	#nmap 
	YELLOW "Installing nmap..."
	sudo apt-get install -y nmap

	
	#sqlite browser
	YELLOW "Installing sqlitebrowser..."
	sudo apt-get install -y sqlitebrowser



	#cmake
	YELLOW "Installing cmake..."
	sudo apt install -y cmake


	# hydra
	YELLOW "Installing Hydra..."
	sudo apt install -y hydra


	#	john the ripper

	#YELLOW "Installing John The Ripper"
	#sudo apt-get install build-essential libssl-dev -y
#	cd /opt/
#	sudo git clone https://github.com/openwall/john.git -b bleeding-jumbo john
#	cd /opt/john/src
#	sudo ./configure 
#	sudo make -s clean && sudo make -sj4



}


if [[ "$1" == "base" ]]
then
	base_install
fi

if [[ "$1" == "tools" ]]
then
	install_tools;
fi	







