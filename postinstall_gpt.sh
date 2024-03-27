#!/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa ser executado como root. Por favor, utilize sudo." 2>&1
  exit 1
fi

# Variáveis
username=$(id -u -n 1000)
builddir=$(pwd)
download_dir="$HOME/Downloads"

# Criação de diretórios se não existirem
mkdir -p /home/$username/.config /home/$username/.fonts /home/$username/Pictures/backgrounds

# Altera as permissões dos diretórios
chown -R $username:$username /home/$username

# Atualização do sistema
apt update
apt upgrade -y

# Instalação de pacotes essenciais
apt install -y build-essential gdebi dkms linux-headers-$(uname -r) ffmpeg default-jdk git wget nano vim htop locate p7zip p7zip-full thunderbird unzip curl cifs-utils flatpak gnome-software-plugin-flatpak neofetch htop libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi libx11-dev libxft-dev libxinerama-dev libx11-xcb-dev libxcb-res0-dev firmware-linux firmware-linux-nonfree intel-microcode fonts-crosextra-carlito fonts-crosextra-caladea ttf-mscorefonts-installer rar unrar snapd gnome-shell-extensions chrome-gnome-shell ocs-url blueman pulseaudio-module-bluetooth

# Adiciona repositório non-free ao sources.list
sed -i 's/main/main contrib non-free/' /etc/apt/sources.list

# Atualiza os pacotes após adicionar o repositório non-free
apt update

# Configurações adicionais
echo "Configurando ambiente de trabalho..."
echo "alias ll='ls -alF'" >> /home/$username/.bashrc
git config --global user.name "wesscd"
git config --global user.email "wesscd@gmail.com"

# Download e instalação de temas
echo "Baixando e instalando temas..."
mkdir -p ~/.themes
wget -O ~/Downloads/Numix.zip https://github.com/numixproject/numix-icon-theme-circle/archive/master.zip
unzip -q ~/Downloads/Numix.zip -d ~/.themes
mv ~/.themes/numix-icon-theme-circle-master ~/.themes/Numix-Circle
rm ~/Downloads/Numix.zip

# Baixar e instalar fontes
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
mv dotfonts/fontawesome/otfs/*.otf /home/$username/.fonts/
chown $username:$username /home/$username/.fonts/*
fc-cache -vf
rm ./FiraCode.zip ./Meslo.zip

# Instalação do Google Chrome, Steam e Spotify
chrome_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
steam_url="https://repo.steampowered.com/steam/archive/precise/steam_latest.deb"
spotify_url="https://repository-origin.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.1.68.632.g2b11de83-38_amd64.deb"

download_deb() {
    local url=$1
    local filename=$(basename $url)
    echo "Baixando $filename..."
    wget -q --show-progress -O "$download_dir/$filename" "$url"
}

install_deb() {
    local deb_file=$1
    echo "Instalando $deb_file..."
    apt install -y "$deb_file"
}

download_deb "$chrome_url"
download_deb "$steam_url"
download_deb "$spotify_url"

install_deb "$download_dir/$(basename $chrome_url)"
install_deb "$download_dir/$(basename $steam_url)"
install_deb "$download_dir/$(basename $spotify_url)"

rm $download_dir/*.deb

# Download e instalação de temas de cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $builddir
rm -rf Nordzy-cursors

# Finalização do script
echo "Script de pós-instalação concluído! Aproveite seu Debian topzeira da balada!"
echo "Para customizar seu bash: https://github.com/ohmybash/oh-my-bash/tree/master/themes"
