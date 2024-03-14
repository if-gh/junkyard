#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/utils.sh"

echo -e "${BBLUE}Installing VSCode extensions...${RST}"
cat "${SCRIPT_DIR}/vscode.extensions" | while read ext
do
    echo -e "    ${BBLUE}Installing:${RST} ${ext}"
    code --install-extension "${ext}" >/dev/null
done
