#!/bin/bash

# Versão do script
SCRIPT_VERSION="1.0"

# Funções
function check_user() {
  if [[ <span class="math-inline">EUID -ne 0 ]]; then
echo "Você precisa executar o script como root\."
exit 1
fi
}
function check_version() {
local current_version=</span>(lsb_release -cs)
  if [[ $current_version != "bookworm" ]]; then
    echo "Este script é compatível apenas com o Debian 12 (Bookworm)."
    echo "Sua versão: $current_version"
    exit 1
  fi
}

function install_package() {
  local package_name=$1
  echo "Instalando $package_name..."
  sudo apt install -y "$package_name"
}

function install_deb() {
  local deb_file=$1
  echo "Instalando $deb_file..."
  sudo apt install -y "$deb_file"
}

function download_deb() {
  local url=<span class="math-inline">1
local filename=</span>(basename $url)
  echo "Baixando $filename..."
  wget -q --show-progress -O "$download_dir/$filename" "$url"
}

function configure_environment() {
  echo "Configurando ambiente de trabalho..."
  # Exemplo: Configuração de aliases para o terminal
  echo "alias ll='ls -alF'" >> ~/.bashrc

  # Configuração do Git (opcional, se você usa o Git)
  git config --global user.name "wesscd"
  git config --global user.email "wesscd@gmail.com"
}

function install_fonts() {
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
}

function install_nordzy_cursor() {
  git clone https://github.com/alvatip/Nordzy-cursors
  cd Nordzy-cursors
  ./install.sh
  cd <span class="math-inline">builddir
rm -rf Nordzy-cursors</1>
}
function install_themes() {
mkdir -p ~/.themes
wget -O ~/Downloads/Numix.zip https://github.com/numixproject/numix-icon-theme-circle/archive/master.zip
unzip -q ~/Downloads/Numix.zip -d ~/.themes
mv ~/.themes/numix-icon-theme-circle-master ~/.themes/Numix-Circle
rm ~/Downloads/Numix.zip
# Instalação de temas adicionais \(opcional\)
# \.\.\.
}
function install_snap() {
sudo apt install -y snapd
}
function install_gnome_extensions(){
sudo apt install -y gnome-shell-extensions chrome-gnome-shell ocs-url
}
function install_nordic_theme(){
cd /usr/share/themes/
git clone https://github\.com/EliverLara/Nordic\.git
git clone https://github\.com/EliverLara/Nordic\-Darker\.git
}
# Variáveis
username=</span>(id -u -n 1000)
builddir=$(pwd)
download_dir="<span class="math-inline">HOME/Downloads"
# Início do script
check_user
check_version
# Atualiza a lista de pacotes e atualiza os pacotes existentes
sudo apt update
sudo apt upgrade -y
# Instalação de pacotes essenciais
install_package "build\-essential"
install_package "gdebi"
install_package "dkms"
install_package "linux\-headers\-</span>(uname -r)"
install_package "ffmpeg"
install_package "default-jdk"
install_package "git"
install_package "wget"
install_package "nano"
install_package "vim

# Instalação dos pacotes .deb
download_deb "$chrome_url"
download_deb "$steam_url"
download_deb "$spotify_url"

install_deb "$download_dir/$(basename $chrome_url)"
install_deb "$download_dir/$(basename $steam_url)"
install_deb "$download_dir/$(basename $spotify_url)"

