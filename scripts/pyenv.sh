#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/utils.sh"

# Install pyenv
echo -e "${BBLUE}Installing pyenv...${RST}"
if ! [ -d "${HOME}/.pyenv" ]; then
    # Directory doesn't exist
    curl https://pyenv.run | bash >/dev/null
else
    if git -C "${HOME}/.pyenv" rev-parse &>/dev/null; then
        # Directory exists and is a git repo
        git -C "${HOME}/.pyenv" pull >/dev/null
    else
        rm -rf "${HOME}/.pyenv"
        curl https://pyenv.run | bash >/dev/null
    fi
fi
