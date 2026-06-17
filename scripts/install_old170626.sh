#! /bin/sh
trap "exit 1" INT

pacman_i() {
	sudo pacman -S "$@"
}

printf "Choose your package manager? (paru or yay): "
read pkg_mng
if [ "$pkg_mng" != "paru" ] && [ "$pkg_mng" != "yay" ]; then
	echo "Invalid option."
	exit 1
fi

if ! command -v $pkg_mng >/dev/null 2>&1; then
	echo "$pkg_mng not found. Please install here:"
	echo "https://aur.archlinux.org/$pkg_mng.git"
	exit 1
fi

pacman_i hyprland ly zsh stow git rofi bluez bluez-utils xdg-user-dirs
xdg-user-dirs-update
chsh -s /bin/zsh

pacman_i xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal
pacman_i pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber

valid_file_mng="nautilus nemo thunar dolphin yazi ranger"
printf "Choose your file managers (space-separated)\n"
printf "Possible options ($valid_file_mng):\n"
read file_mng
for choice in $file_mng; do
	echo "$valid_file_mng" | grep -qw "$choice" || { echo "Invalid option: $choice"; exit 1; }
done

pacman_i $file_mng

# Shell tools
$pkg_mng -S grep tree less fzf starship --noconfirm

# Alternatives
$pkg_mng -S zoxide lsd bat diff-so-fancy --noconfirm

# TUI programs
$pkg_mng -S btop fastfetch

# Programming specific
$pkg_mng -S asdf-vm neovim

# Fonts and themes
$pkg_mng -S inter-font noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-cascadia-code-nerd ttf-firacode-nerd ttf-nerd-fonts-symbols --noconfirm

# Install Rust
printf "Install Rust? (y)es/(n)o: "
read rust_res
case "${rust_res,,}" in
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
services="ly bluetooth"
for s in $services; do
	systemctl enable "$s"
done

# Enable user_services
user_services="pipewire pipewire-pulse wireplumber"
for s in $user_services; do
	systemctl --user enable --now "$s"
done

cd ~/dotfiles && stow .
