# borealissaile/dotfiles

Configurações pessoais para **Arch Linux** com **Hyprland** como compositor Wayland. Gerenciado com [GNU Stow](https://www.gnu.org/software/stow/) para deploy rápido em novas máquinas.

## Índice

- [Destaques](#destaques)
- [Instalação Rápida](#instalação-rápida)
- [Pacotes Instalados](#pacotes-instalados)
- [Atalhos do Hyprland](#atalhos-do-hyprland)
- [Estrutura do Repositório](#estrutura-do-repositório)
- [Plugins Zsh](#plugins-zsh)
- [Manutenção](#manutenção)
- [Personalização](#personalização)

## Destaques

- **Hyprland** — Compositor Wayland com animações suaves e temas dinâmicos
- **Ghostty** — Terminal rápido com GPU acceleration e tema Zeists
- **Starship** — Prompt minimalista e informativo
- **Zinit** — Gerenciador de plugins Zsh com carregamento instantâneo
- **Waybar** — Barra de status com workspaces, áudio, CPU e memória
- **Rofi** — Lançador de aplicações customizado com tema próprio
- **Zoxide + Fzf** — Navegação fuzzy por diretórios e arquivos
- **Lsd + Bat** — Alternativas modernas para `ls` e `cat`
- **Fastfetch** — Informações do sistema com logo em kitty-direct
- **Wallpaper dinâmico** — Troca via script com `zenity` + `swww`
- **GNU Stow** — Todos os dotfiles são gerenciados como symlinks

## Instalação Rápida

```bash
# Clone o repositório
git clone https://github.com/borealissaile/dotfiles.git ~/dotfiles

# Execute o instalador
cd ~/dotfiles && ./scripts/install.sh
```

O instalador pergunta qual AUR helper usar (`paru` ou `yay`), quais gerenciadores de arquivo instalar (opcional) e se deseja configurar o Rust toolchain.

Após a instalação, todos os dotfiles são linkados automaticamente com `stow .`.

### Manual

Caso prefira instalar pacote por pacote, consulte a seção [Pacotes Instalados](#pacotes-instalados) e depois execute:

```bash
cd ~/dotfiles && stow .
```

## Pacotes Instalados

| Categoria | Programas |
|-----------|-----------|
| **Compositor** | Hyprland, xdg-desktop-portal-hyprland, xdg-desktop-portal |
| **Display Manager** | ly |
| **Shell** | zsh, starship, zinit, zoxide, fzf |
| **Terminal** | ghostty |
| **Barra** | waybar |
| **Launcher** | rofi |
| **Áudio** | pipewire, pipewire-pulse, wireplumber, pavucontrol |
| **Screenshot** | grim, slurp, wl-clipboard |
| **Wallpaper** | swww (via `awww`) |
| **Fontes** | CaskaydiaCove Nerd Font, JetBrainsMono Nerd Font, FiraCode Nerd Font, Inter, Noto, Symbols Nerd |
| **CLI Tools** | lsd, bat, diff-so-fancy, btop, fastfetch, tty-clock, acpi |
| **Editor** | neovim (VS Code opcional, não incluso no instalador) |
| **Dev Tools** | asdf-vm, nvm, git, rustup |
| **Gerenciador de Arquivos** | nautilus (ou nemo/thunar/dolphin/yazi/ranger) |
| **Autenticação** | polkit-kde-authentication-agent-1 |
| **Input Method** | fcitx5, qt6ct |
| **System Utils** | brightnessctl, playerctl |
| **Apps** | brave-bin, telegram-desktop, discord, spotify-launcher |
| **Logout** | wlogout |

## Atalhos do Hyprland

| Atalho | Ação |
|--------|------|
| `SUPER` + `T` | Abrir terminal (Ghostty) |
| `SUPER` + `SPACE` | Menu Rofi (drun/window/filebrowser) |
| `SUPER` + `B` | Brave Browser |
| `SUPER` + `C` | VS Code |
| `SUPER` + `F` | Gerenciador de arquivos |
| `SUPER` + `G` | Telegram |
| `SUPER` + `D` | Discord |
| `SUPER` + `M` | Spotify |
| `SUPER` + `Q` / `ALT` + `F4` | Fechar janela |
| `SUPER` + `X` | Alternar floating/tiling |
| `SUPER` + `1-0` | Ir para workspace 1-10 |
| `SUPER` + `SHIFT` + `1-0` | Mover janela para workspace 1-10 |
| `SUPER` + `H/L` | Workspace anterior/próximo |
| `SUPER` + `SHIFT` + `H/L` | Mover janela para workspace anterior/próximo |
| `SUPER` + `ALT` + `H/J/K/L` | Redimensionar janela |
| `SUPER` + `CTRL` + `H/J/K/L` | Mover foco entre janelas |
| `SUPER` + `HOME` | Sair do Hyprland |
| `PRINT` | Screenshot da tela toda |
| `SUPER` + `SHIFT` + `S` | Screenshot de área |
| `SUPER` + `ALT` + `S` | Screenshot da janela ativa |
| `XF86AudioRaiseVolume` / `LowerVolume` | Aumentar / diminuir volume |
| `XF86AudioMute` / `MicMute` | Mutar áudio / microfone |
| `XF86MonBrightnessUp` / `Down` | Aumentar / diminuir brilho |
| `XF86AudioNext` / `Prev` / `Play` | Controle de mídia |

## Estrutura do Repositório

```
dotfiles/
├── .alias                    # Aliases do shell (git, ls, cat, navegação)
├── .gitconfig                # Configuração global do Git
├── .instant.zsh              # Carregamento instantâneo do Zsh
├── .zshrc                    # Configuração principal do Zsh
├── .config/
│   ├── fastfetch/            # Informações do sistema (logo Arch)
│   ├── ghostty/              # Terminal emulador + tema Zeists
│   ├── hypr/                 # Hyprland (compositor Wayland)
│   │   ├── hyprland.conf     #   Arquivo principal
│   │   └── conf/             #   Módulos (input, keybinds, animações, etc.)
│   ├── neofetch/             # Fallback system info
│   ├── rofi/                 # Lançador de aplicações (tema customizado)
│   ├── scripts/              # Scripts utilitários
│   │   ├── change_wpp.sh     #   Troca de wallpaper
│   │   └── run_rofi.sh       #   Lançamento do Rofi
│   ├── starship.toml         # Prompt do shell
│   └── waybar/               # Barra de status (config + CSS)
├── .icons/                   # Tema de cursores Colloid
├── .stow-local-ignore        # Arquivos ignorados pelo stow
├── doc/
│   └── prompt.md             # Prompt de auditoria
├── scripts/
│   ├── install.sh            # Instalador completo
│   └── gen_ssh.sh            # Gerador de chave SSH
├── Makefile                  # Atalhos para sync e wallpapers
└── README.md                 # Este arquivo
```

## Plugins Zsh

| Plugin | Função |
|--------|--------|
| [Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab) | Completação com interface fuzzy |
| [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Sugestões baseadas no histórico |
| [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) | Completações extras |
| [jeffreytse/zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode) | Modo vi para o shell |
| [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Syntax highlight no prompt |

## Manutenção

```bash
make sync       # Atualiza os dotfiles (git pull)
make get_wpp    # Clona repositório de wallpapers
make sync_wpp   # Atualiza wallpapers
```

## Personalização

- **Tema do Hyprland** — Edite `~/.config/hypr/conf/themes.conf` (cores, gaps, blur, bordas). `visual.conf` contém opacidades e tearing; `themes.conf` sobrescreve os valores visuais.
- **Prompt** — Modifique `~/.config/starship.toml`
- **Terminal** — Alterne o tema em `~/.config/ghostty/config` (campo `theme`)
- **Wallpaper** — Use o atalho no Waybar ou execute `~/.config/scripts/change_wpp.sh`
- **Cores do Waybar** — Edite `~/.config/waybar/style.css`

## Licença

MIT
