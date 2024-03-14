# Single Letters
alias p="sudo pacman"
alias v="nvim"
alias y="yay"

# QoL Replacements
alias cat="bat"
alias locate="plocate"
alias ls="exa"
alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias sudo="sudo "
alias top="btm"
alias rcp="rsync -hirtP --info=stats2 --modify-window=2 --chmod=Du+rwx,go-rwx,Fu+rw,go-rw --no-perms"
alias rmv="rsync -hirtP --info=stats2 --modify-window=2 --chmod=Du+rwx,go-rwx,Fu+rw,go-rw --no-perms --remove-source-files"
eval "$(zoxide init zsh)"
eval $(thefuck --alias)

# Editing
alias vi="nvim"
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"

# Docker
alias dr="docker run -it --rm"
alias dcu="docker compose up --remove-orphans --build -d"
alias dcd="docker compose down --remove-orphans"
alias dcl="docker compose logs"
alias dsp="docker system prune -a -f"

# Ansible
alias ap="ansible-playbook"
