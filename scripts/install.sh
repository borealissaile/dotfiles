#!/usr/bin/env bash

set -euo pipefail

trap 'echo "Instalação interrompida."; exit 1' INT

pacman_i() {
    sudo pacman -S --needed --noconfirm "$@"
}

echo "========================================="
echo " Dotfiles Installer"
echo "========================================="
echo

read -rp "Escolha seu helper AUR (paru/yay): " pkg_mng

if [[ "$pkg_mng" != "paru" && "$pkg_mng" != "yay" ]]; then
    echo "Opção inválida."
    exit 1
fi

if ! command -v "$pkg_mng" >/dev/null 2>&1; then
    echo "$pkg_mng não encontrado."
    echo
    echo "Instale primeiro:"
    echo "https://aur.archlinux.org/${pkg_mng}.git"
    exit 1
fi

<<<<<<< HEAD
echo
echo "Atualizando diretórios do usuário..."
=======
pacman_i hyprland ly zsh stow git rofi xdg-user-dirs
>>>>>>> 63e7e17 (chore(install): sincroniza pacotes com as configs atuais)
xdg-user-dirs-update

<<<<<<< HEAD
echo
echo "Instalando pacotes base..."

pacman_i \
    zsh \
    git \
    stow \
    ghostty \
    fastfetch \
    fzf \
    grep \
    tree \
    less \
    wget \
    curl \
    zip \
    unzip \
    rsync

echo
echo "Definindo ZSH como shell padrão..."

if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

echo
echo "Escolha seu gerenciador de arquivos:"
echo
echo "  1) yazi"
echo "  2) ranger"
echo "  3) thunar"
echo "  4) dolphin"
echo "  5) nautilus"
echo "  6) nemo"
echo

read -rp "Digite um ou mais nomes separados por espaço: " file_mng
=======
pacman_i xdg-desktop-portal-hyprland xdg-desktop-portal
pacman_i pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
>>>>>>> 63e7e17 (chore(install): sincroniza pacotes com as configs atuais)

# Image / Screenshot / Power
pacman_i swww grim slurp wl-clipboard jq zenity pavucontrol

valid_file_mng="nautilus nemo thunar dolphin yazi ranger"
<<<<<<< HEAD

for choice in $file_mng; do
    echo "$valid_file_mng" | grep -qw "$choice" || {
        echo "Gerenciador inválido: $choice"
        exit 1
    }
done

pacman_i $file_mng

echo
echo "Instalando ferramentas CLI..."
=======
printf "Choose your file managers (space-separated)\n"
printf "Possible options ($valid_file_mng):\n"
read file_mng
if [ -z "$file_mng" ]; then
	echo "No file manager selected. Skipping."
else
	for choice in $file_mng; do
		echo "$valid_file_mng" | grep -qw "$choice" || { echo "Invalid option: $choice"; exit 1; }
	done
	pacman_i $file_mng
fi

# Shell tools
$pkg_mng -S fzf starship --noconfirm
>>>>>>> 63e7e17 (chore(install): sincroniza pacotes com as configs atuais)

"$pkg_mng" -S --noconfirm \
    starship \
    zoxide \
    lsd \
    bat \
    diff-so-fancy \
    btop

<<<<<<< HEAD
echo
echo "Instalando ferramentas de desenvolvimento..."

"$pkg_mng" -S --noconfirm \
    asdf-vm \
    neovim

echo
echo "Instalando fontes..."

"$pkg_mng" -S --noconfirm \
    inter-font \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    ttf-cascadia-code-nerd \
    ttf-firacode-nerd \
    ttf-nerd-fonts-symbols

echo
read -rp "Instalar Docker? (s/n): " docker_res

case "${docker_res,,}" in
    s|sim|y|yes)

        pacman_i docker docker-compose

        sudo systemctl enable docker
        sudo systemctl start docker

        sudo usermod -aG docker "$USER"

        echo
        echo "Docker instalado."
        echo "Faça logout/login para usar Docker sem sudo."
        ;;
esac

echo
read -rp "Instalar Rust? (s/n): " rust_res
=======
# TUI programs
$pkg_mng -S btop fastfetch --noconfirm

# GUI multimedia (AUR)
$pkg_mng -S wlogout --noconfirm

# System utilities
$pkg_mng -S brightnessctl playerctl --noconfirm

# Input method
$pkg_mng -S fcitx5 --noconfirm

# QT theming
$pkg_mng -S qt6ct --noconfirm

# Authentication agent
$pkg_mng -S polkit-kde-authentication-agent-1 --noconfirm

# Wallpaper daemon
$pkg_mng -S awww --noconfirm

# Terminal
$pkg_mng -S ghostty --noconfirm

# Apps
$pkg_mng -S brave-bin telegram-desktop discord spotify-launcher --noconfirm

# Programming specific
$pkg_mng -S asdf-vm neovim --noconfirm

# CLI tools
$pkg_mng -S tty-clock acpi --noconfirm

# Fonts and themes
$pkg_mng -S inter-font noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-cascadia-code-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols --noconfirm

# NVM
$pkg_mng -S nvm --noconfirm

# Install Rust
printf "Install Rust? (y)es/(n)o: "
read rust_res
_rust_res=$(printf '%s' "$rust_res" | tr '[:upper:]' '[:lower:]')
case "$_rust_res" in
	y|yes|s|sim)
		pacman_i rustup
		rustup default stable
		rustup component add rust-analyzer
		;;
	n|no|nao)
		;;
	*)
		echo "Skipping."
		;;
esac

# Enable services
services="ly"
for s in $services; do
	systemctl enable "$s"
done
>>>>>>> 63e7e17 (chore(install): sincroniza pacotes com as configs atuais)

case "${rust_res,,}" in
    s|sim|y|yes)

        pacman_i rustup

        rustup default stable

        rustup component add rust-analyzer
        ;;
esac

echo
echo "Aplicando dotfiles..."

if [[ -d "$HOME/dotfiles" ]]; then
    cd "$HOME/dotfiles"
    stow .
else
    echo
    echo "Aviso:"
    echo "~/dotfiles não encontrado."
    echo "Pulando aplicação dos dotfiles."
fi

echo
echo "========================================="
echo " Instalação concluída!"
echo "========================================="
echo
echo "Recomendações:"
echo
echo "1. Faça logout/login"
echo "2. Verifique se o Ghostty abre corretamente"
echo "3. Execute: fastfetch"
echo "4. Reinicie o sistema se desejar"
echo