#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/utils.sh"

# Oh My Zsh
echo -e "${BBLUE}Installing OhMyZsh...${RST}"
if ! [ -d "${HOME}/.oh-my-zsh" ]; then
    # Directory doesn't exist
    echo -e "    ${BBLUE}Installing OMZ in:${RST} ${HOME}/.oh-my-zsh"
    sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        "" --unattended >/dev/null
else
    if git -C "${HOME}/.oh-my-zsh" rev-parse &>/dev/null; then
        # Directory exists and is a git repo
        echo -e "    ${BBLUE}Updating OMZ in:${RST} ${HOME}/.oh-my-zsh"
        git -C "${HOME}/.oh-my-zsh" pull >/dev/null
    else
        # Directory exists but is not a git repo
        echo -e "    ${BBLUE}Invalid OMZ directory found, reinstalling...${RST}"
        rm -rf "${HOME}/.oh-my-zsh"
        sh -c \
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
            "" --unattended >/dev/null
    fi
fi

# OMZ Theme
echo -e "${BBLUE}Installing OMZ PowerLevel10K theme...${RST}"
git_clone_or_update \
    "--depth=1" \
    "https://github.com/romkatv/powerlevel10k.git" \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
# OMZ Plugins
echo -e "${BBLUE}Installing OMZ Plugins...${RST}"
git_clone_or_update \
    "--depth=1" \
    "https://github.com/zsh-users/zsh-autosuggestions.git" \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git_clone_or_update \
    "--depth=1" \
    "https://github.com/zsh-users/zsh-completions.git" \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions"
git_clone_or_update \
    "--depth=1" \
    "https://github.com/zsh-users/zsh-history-substring-search.git" \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
git_clone_or_update \
    "--depth=1" \
    "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

chsh -s /usr/bin/zsh "$(whoami)"
