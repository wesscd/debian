#!/bin/bash

# Atualiza a lista de pacotes e atualiza os pacotes existentes
sudo apt update
sudo apt upgrade -y

# Instalação de pacotes essenciais
sudo apt install -y gdebi build-essential dkms linux-headers-$(uname -r) ffmpeg default-jdk git wget nano vim htop locate p7zip p7zip-full unzip curl cifs-utils flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalação de utilitários adicionais
sudo apt install -y neofetch htop 

# Instalação de codecs de áudio e vídeo
sudo apt install -y libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi

# Instalação de firmwares para Intel
sudo apt install -y firmware-linux firmware-linux-nonfree intel-microcode

# Instalação de msfonts
sudo apt install -y fonts-crosextra-carlito fonts-crosextra-caladea ttf-mscorefonts-installer rar unrar

# Instalação do Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y
rm google-chrome-stable_current_amd64.deb

# Instalação do Snap
sudo apt install -y snapd

# Instalação do Steam
sudo snap install steam

# Instalação do Spotify via Snap
sudo snap install spotify

# Instalação de plugins do GNOME Look
sudo apt install -y gnome-shell-extensions chrome-gnome-shell ocs-url

# Instalação de temas Nordic-Darker
sudo apt install -y gnome-shell-extension-prefs gnome-tweaks
git clone https://github.com/EliverLara/Nordic-Darker.git ~/Downloads/Nordic-Darker
mkdir -p ~/.themes
mv ~/Downloads/Nordic-Darker/ ~/.themes/

# Configuração do ambiente de trabalho
echo "Configurando ambiente de trabalho..."
# Exemplo: Configuração de aliases para o terminal
echo "alias ll='ls -alF'" >> ~/.bashrc

# Configuração do Git (opcional, se você usa o Git)
git config --global user.name "wesscd"
git config --global user.email "wesscd@gmail.com"

# Adiciona repositório non-free ao sources.list
sudo sed -i 's/main/main contrib non-free/' /etc/apt/sources.list

# Atualiza novamente os pacotes após adicionar o repositório non-free
sudo apt update

# Instalação de drivers adicionais (caso necessário)
# Exemplo: Drivers NVIDIA
# sudo apt install -y nvidia-driver

# Instalação de pacotes para Bluetooth
sudo apt install -y blueman pulseaudio-module-bluetooth

# Remoção de pacotes desnecessários
sudo apt autoremove -y

# Adicionando novos wallpapers e temas
echo "Baixando novos wallpapers e temas..."
mkdir -p ~/Pictures/Wallpapers
wget -P ~/Pictures/Wallpapers/ https://wallpaperaccess.com/full/191581.jpg
wget -P ~/Pictures/Wallpapers/ https://wallpaperaccess.com/full/271194.jpg

# Baixar e instalar temas de ícones e temas de janelas
echo "Baixando e instalando temas..."
mkdir -p ~/.themes
wget -O ~/Downloads/Numix.zip https://github.com/numixproject/numix-icon-theme-circle/archive/master.zip
unzip -q ~/Downloads/Numix.zip -d ~/.themes
mv ~/.themes/numix-icon-theme-circle-master ~/.themes/Numix-Circle
rm ~/Downloads/Numix.zip

echo "Script de pós-instalação concluído! Aproveite seu Debian topzeira da balada!"
