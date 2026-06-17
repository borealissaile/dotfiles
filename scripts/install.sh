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

valid_file_mng="nautilus nemo thunar dolphin yazi ranger"

for choice in $file_mng; do
    echo "$valid_file_mng" | grep -qw "$choice" || {
        echo "Gerenciador inválido: $choice"
        exit 1
    }
done

pacman_i $file_mng

echo
echo "Instalando ferramentas CLI..."

"$pkg_mng" -S --noconfirm \
    starship \
    zoxide \
    lsd \
    bat \
    diff-so-fancy \
    btop

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