#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/utils.sh"

# Passwordless sudo
echo -e "${BBLUE}Setting passwordless sudo...${RST}"
if ! sudo grep -q "^$(whoami).*NOPASSWD:" /etc/sudoers; then
    echo "$(whoami) ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
else
    echo -e "    ${BGREEN}Already have passwordless sudo!${RST}"
fi

# No debug for makepkg -si
echo -e "${BBLUE}Setting no debug for makepkg...${RST}"
sudo sed -i "s/purge debug lto/purge !debug lto/g" /etc/makepkg.conf

# Check/install yay
echo -e "${BBLUE}Checking/installing yay...${RST}"
if ! command -v yay &>/dev/null; then
    git_clone_or_update \
        "--depth=1" \
        "https://aur.archlinux.org/yay-bin.git" \
        "/tmp/yay-bin"
    cd /tmp/yay-bin
    makepkg -si --needed --noconfirm
    if ! command -v yay &>/dev/null; then
        echo -e "    ${BRED}Error: Failed to install yay!${RST}"
        exit 1
    else
        echo -e "    ${BGREEN}Installed yay:${RST} $(which yay)"
    fi
else
    echo -e "    ${BGREEN}Command yay found:${RST} $(which yay)"
fi

PKG_INSTALL="yay -S --needed --noconfirm"
${PKG_INSTALL} -yu >/dev/null

# Install essential packages
echo -e "${BBLUE}Installing essential packages...${RST}"
declare -a essentials=(
    amd-ucode
    chezmoi  # dotfiles manager
    git
    inte-ucode
    less
    man-db
    man-pages
    mkinitcpio-firmware
    neovim
    openssh
    tmux
    wget
    zsh
)
for pkg in "${essentials[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done

# Install system management tools
echo -e "${BBLUE}Installing system management tools...${RST}"
declare -a sysmans=(
    dosfstools
    exfatprogs
    gnu-netcat
    lsof
    monit
    ncdu
    netstat
    nmap
    nvtop
    iftop
    iotop
    iptraf-ng
    powertop
    sbctl
    sysstat
    tcpdump
    traceroute
)
for pkg in "${sysmans[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done

# Install dev tools
echo -e "${BBLUE}Installing dev tools...${RST}"
declare -a devtools=(
    entr
    go
    jq
    nvm
    rustup
    shfmt
    tk  # for "pyenv install"
)
for pkg in "${devtools[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done

# Install QoL CLI tools
echo -e "${BBLUE}Installing QoL CLI tools...${RST}"
declare -a qoltools=(
    bat # cat
    bottom # top
    exa # ls
    fzf
    mc
    plocate # locate
    rclone
    rsync # cp
    rmlint
    rmtrash # rm / rmdir
    thefuck
    tldr # man
    zoxide # cd
)
for pkg in "${qoltools[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done
sudo systemctl enable plocate-updatedb.timer

# Install bloats
echo -e "${BBLUE}Installing bloats...${RST}"
declare -a bloats=(
    asciiquarium
    cowfortune
    espeak-ng
    neofetch
    sl
    toipe
)
for pkg in "${bloats[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done

# Install desktop environment
echo -e "${BBLUE}Installing desktop environment...${RST}"
declare -a de_pkgs=(
    ly
    qt5
    qt5ct
    qt6
    qt6ct
    gbm
    libdrm
    libpipewire
    polkit-kde-agent
    sdbus-cpp
    xdg-desktop-portal-hyprland
    hyprlang
    hyprland
    dunst
    rofi
    waybar
    pamixer
    pavucontrol
)
for pkg in "${de_pkgs[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done
echo -e "${BBLUE}Enabling display manager...${RST}"
sudo mkdir -p /etc/ly
sudo cp "${SCRIPT_DIR}/../etc/ly/config.ini" /etc/ly/config.ini
sudo systemctl enable ly.service

# Install fonts and themes
echo -e "${BBLUE}Installing fonts and themes...${RST}"
declare -a assets=(
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    ttf-hack-nerd
    ttf-meslo-nerd
    ttf-noto-nerd
    ttf-nerd-fonts-symbols
    ttf-nerd-fonts-symbols-mono
    inkscape
    yaru-colors-icon-theme
    yaru-colors-gtk-theme
)
for pkg in "${assets[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done

# Install desktop apps
echo -e "${BBLUE}Installing desktop apps...${RST}"
declare -a d_apps=(
    code
    dolphin
    firefox
    kitty
)
for pkg in "${d_apps[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done

# Install gaming apps
echo -e "${BBLUE}Installing gaming apps...${RST}"
declare -a g_apps=(
    gamescope
    gamemode
    libretro
    lutris
    mangohud
    steam
)
for pkg in "${g_apps[@]}"; do
    echo -e "    ${BBLUE}Installing:${RST} ${pkg}"
    ${PKG_INSTALL} "${pkg}" >/dev/null
done
