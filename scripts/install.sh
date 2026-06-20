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

echo
echo "Atualizando diretórios do usuário..."
xdg-user-dirs-update

echo
echo "Instalando pacotes base..."
pacman_i \
    hyprland ly zsh stow git rofi \
    xdg-desktop-portal-hyprland xdg-desktop-portal \
    pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber \
    swww grim slurp wl-clipboard jq zenity pavucontrol

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
echo "(pressione Enter para pular)"
read -rp "Digite um ou mais números separados por espaço: " file_choices

file_mng=""
for choice in $file_choices; do
    case "$choice" in
        1) file_mng="$file_mng yazi" ;;
        2) file_mng="$file_mng ranger" ;;
        3) file_mng="$file_mng thunar" ;;
        4) file_mng="$file_mng dolphin" ;;
        5) file_mng="$file_mng nautilus" ;;
        6) file_mng="$file_mng nemo" ;;
        *) echo "Opção inválida: $choice"; exit 1 ;;
    esac
done

if [ -n "$file_mng" ]; then
    pacman_i $file_mng
fi

echo
echo "Instalando ferramentas CLI..."
"$pkg_mng" -S --noconfirm \
    fzf starship zoxide lsd bat diff-so-fancy btop fastfetch \
    brightnessctl playerctl tty-clock acpi

echo
echo "Instalando input method e QT..."
"$pkg_mng" -S --noconfirm fcitx5 qt6ct polkit-kde-authentication-agent-1

echo
echo "Instalando daemon de wallpaper..."
"$pkg_mng" -S --noconfirm awww wlogout

echo
echo "Instalando terminal..."
"$pkg_mng" -S --noconfirm ghostty

echo
echo "Instalando aplicativos..."
"$pkg_mng" -S --noconfirm brave-bin telegram-desktop discord spotify-launcher

echo
echo "Instalando ferramentas de desenvolvimento..."
"$pkg_mng" -S --noconfirm asdf-vm neovim nvm

echo
echo "Instalando fontes..."
"$pkg_mng" -S --noconfirm \
    inter-font noto-fonts noto-fonts-cjk noto-fonts-emoji \
    ttf-cascadia-code-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

echo
read -rp "Instalar Docker? (s/n): " docker_res

case "${docker_res,,}" in
    s|sim|y|yes)
        pacman_i docker docker-compose
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker "$USER"
        echo
        echo "Docker instalado. Faça logout/login para usar sem sudo."
        ;;
esac

echo
read -rp "Instalar Rust? (s/n): " rust_res

case "${rust_res,,}" in
    s|sim|y|yes)
        pacman_i rustup
        rustup default stable
        rustup component add rust-analyzer
        echo "Rust instalado."
        ;;
esac

echo
echo "Habilitando serviços..."
sudo systemctl enable ly

echo
echo "Aplicando dotfiles..."
if [[ -d "$HOME/dotfiles" ]]; then
    cd "$HOME/dotfiles"
    stow .
else
    echo "Aviso: ~/dotfiles não encontrado. Pulando aplicação dos dotfiles."
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
