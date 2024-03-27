#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Você precisa estar como ROOT para rodar o script, por favor execute add sudo ao comando" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Diretório de destino para download dos arquivos .deb
download_dir="$HOME/Downloads"

# Making .config and Moving config files and background to Pictures
cd $builddir

mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds

chown -R $username:$username /home/$username


# Atualiza a lista de pacotes e atualiza os pacotes existentes
sudo apt update
sudo apt upgrade -y

# Install nala
apt install nala -y

# Instalação de pacotes essenciais
sudo apt install -y build-essential gdebi dkms linux-headers-$(uname -r) ffmpeg default-jdk git wget nano vim htop locate p7zip p7zip-full thunderbird unzip curl cifs-utils flatpak gnome-software-plugin-flatpak 

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Oh my bash
git clone https://github.com/ohmybash/oh-my-bash.git

cd oh-my-bash

cd tools

./install.sh

cd ../..

sudo cp -f .bashrc ~/

source ~/.bashrc

# Instalação de utilitários adicionais
sudo apt install -y neofetch htop 

# Instalação de codecs de áudio e vídeo
sudo apt install -y libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi libx11-dev libxft-dev libxinerama-dev libx11-xcb-dev libxcb-res0-dev

# Instalação de firmwares para Intel
sudo apt install -y firmware-linux firmware-linux-nonfree intel-microcode

# Instalação de msfonts
sudo apt install -y fonts-crosextra-carlito fonts-crosextra-caladea ttf-mscorefonts-installer rar unrar

# Baixe o tema do CyberSync
git clone https://github.com/HenriqueLopes42/ThemeGrub.CyberSynchro.git

# Crie o diretório de temas do GRUB se não existir
sudo mkdir -p /boot/grub/themes

# Copie os arquivos para o diretório de temas do GRUB
sudo cp -r ThemeGrub.CyberSynchro /boot/grub/themes/CyberSync

sudo cp /boot/grub/themes/CyberSync/Theme/background.png /home/$username/Pictures/backgrounds/

# Configure o GRUB para usar o tema
echo 'GRUB_THEME="/boot/grub/themes/CyberSync/Theme/theme.txt"' | sudo tee -a /etc/default/grub

# Atualize o GRUB
sudo update-grub

# Instalação do Google Chrome
chrome_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# URL para download do Steam
steam_url="https://repo.steampowered.com/steam/archive/precise/steam_latest.deb"

# URL para download do Spotify
spotify_url="https://repository-origin.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.1.68.632.g2b11de83-38_amd64.deb"

# Função para baixar os arquivos .deb
download_deb() {
    local url=$1
    local filename=$(basename $url)
    echo "Baixando $filename..."
    wget -q --show-progress -O "$download_dir/$filename" "$url"
}

# Função para instalar os arquivos .deb
install_deb() {
    local deb_file=$1
    echo "Instalando $deb_file..."
    sudo apt install -y "$deb_file"
}

# Baixa os arquivos .deb
download_deb "$chrome_url"
download_deb "$steam_url"
download_deb "$spotify_url"

# Instala os pacotes .deb baixados
install_deb "$download_dir/$(basename $chrome_url)"
install_deb "$download_dir/$(basename $steam_url)"
install_deb "$download_dir/$(basename $spotify_url)"

rm *.deb

# Instalação do Snap
sudo apt install -y snapd


# Instalação de plugins do GNOME Look
sudo apt install -y gnome-shell-extensions chrome-gnome-shell ocs-url

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git
git clone https://github.com/EliverLara/Nordic-Darker.git 

# Installing fonts
cd $builddir 
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
mv dotfonts/fontawesome/otfs/*.otf /home/$username/.fonts/
chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $builddir
rm -rf Nordzy-cursors

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

# Baixar e instalar temas de ícones e temas de janelas
echo "Baixando e instalando temas..."
mkdir -p ~/.themes
wget -O ~/Downloads/Numix.zip https://github.com/numixproject/numix-icon-theme-circle/archive/master.zip
unzip -q ~/Downloads/Numix.zip -d ~/.themes
mv ~/.themes/numix-icon-theme-circle-master ~/.themes/Numix-Circle
rm ~/Downloads/Numix.zip

echo "Script de pós-instalação concluído! Aproveite seu Debian topzeira da balada!"
echo "Para customizar seu bash: https://github.com/ohmybash/oh-my-bash/tree/master/themes"
