# Basics
export ARCHFLAGS="-arch x86_64"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="${HOME}/.local/bin:${HOME}/.local/sbin:${PATH}"

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_DIR="/run/user/${UID}"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# GPG
export GNUPGHOME="${HOME}/.gnupg"
export GPG_TTY="${TTY}"

# Python
export PYENV_ROOT="${HOME}/.pyenv"
command -v pyenv >/dev/null || export PATH="${PYENV_ROOT}/bin:${PATH}"
export PYHON_CONFIGURE_OPTS="--enable-framework --enable-shared"
export PIP_CONFIG_FILE="${HOME}/.config/pip/pip.conf"
