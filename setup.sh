#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${ROOT_DIR}/scripts/utils.sh"

if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    source /etc/os-release
    case $ID in
    arch)
        echo -e "${BBLUE}Setting up:${RST} ${PRETTY_NAME}"
        source "${ROOT_DIR}/scripts/arch_setup.sh"
        ;;
    fedora)
        echo -e "${BRED}Error: Not implemented for <${PRETTY_NAME}>!${RST}"
        exit 1
        ;;
    ubuntu)
        echo -e "${BRED}Error: Not implemented for <${PRETTY_NAME}>!${RST}"
        exit 1
        ;;
    *)
        echo -e "${BRED}Error: Not Implemented for <${PRETTY_NAME}>${RST}"
        exit 1
        ;;
    esac
elif [[ "${OSTYPE}" == "darwin"* ]]; then
    echo -e "${BRED}Error: Not implemented for <${OSTYPE}>!${RST}"
    exit 1
elif [[ "${OSTYPE}" == "cygwin" ]]; then
    echo -e "${BRED}Error: Not implemented for <${OSTYPE}>!${RST}"
    exit 1
elif [[ "${OSTYPE}" == "msys" ]]; then
    echo -e "${BRED}Error: Not implemented for <${OSTYPE}>!${RST}"
    exit 1
elif [[ "${OSTYPE}" == "win32" ]]; then
    echo -e "${BRED}Error: Not implemented for <${OSTYPE}>!${RST}"
    exit 1
elif [[ "${OSTYPE}" == "freebsd"* ]]; then
    echo -e "${BRED}Error: Not implemented for <${OSTYPE}>!${RST}"
    exit 1
else
    echo -e "${BRED}Error: Not implemented for <${OSTYPE}>!${RST}"
    exit 1
fi

source "${ROOT_DIR}/scripts/pyenv.sh"
source "${ROOT_DIR}/scripts/omz.sh"
source "${ROOT_DIR}/scripts/vscode.sh"

echo -e "${BBLUE}Copying chezmoi config...${RST}"
mkdir -p "${HOME}/.config/chezmoi"
cp "${ROOT_DIR}/scripts/chezmoi.toml" "${HOME}/.config/chezmoi/"

echo -e "${BBLUE}Applying dotfiles...${RST}"
chezmoi apply -v

echo -e "${BGREEN}Setup finished!${RST}"
