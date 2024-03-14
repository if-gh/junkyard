#!/usr/bin/env bash
set -euo pipefail

# Text Colors
RST='\033[0m'
BBLACK='\033[1;30m'
BRED='\033[1;31m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
BPURPLE='\033[1;35m'
BCYAN='\033[1;36m'

git_clone_or_update() {
    args="${1}"
    git_url="${2}"
    dest_dir="${3}"

    if ! [ -d "${dest_dir}" ]; then
        # Directory doesn't exist
        echo -e "    ${BBLUE}Cloning${RST} ${git_url} ${BBLUE}to${RST} ${dest_dir}"
        git clone "${args}" "${git_url}" "${dest_dir}" >/dev/null
    else
        if git -C "${dest_dir}" rev-parse &>/dev/null; then
            # Directory exists and is a git repo
            echo -e "    ${BBLUE}Updating repo in:${RST} ${dest_dir}..."
            git -C "${dest_dir}" pull >/dev/null
        else
            echo -e "${BRED}Error: ${dest_dir} exists but is not a git repo!${RST}"
            exit 1
        fi
    fi
}
