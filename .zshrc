# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Configuration
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"

# Which plugins would you like to load?
plugins=(
  rails
  git
  colored-man-pages
  npm
  yarn
  forgit # must be loaded after git
)

source $ZSH/oh-my-zsh.sh

# User functions
function search-this() {
    if [[ $# -eq 2 ]]; then
        grep -irn --include "*.$2" "$1" ./*
    else
        grep -irn "$1" ./*
    fi
}

function kssh() {
  kubectl exec --stdin --tty "$1" -- /bin/bash
}

function klogs() {
  kubectl logs "$1" --follow
}

function getpods() {
  kubectl get pods | grep resque
}

function get-aws-creds {
  yawsso login --profile production-us:default
  aws sso login --profile production-eu
  aws sso login --profile production-apac
  aws sso login --profile dashboard-console-read-write
  aws sso login --profile dashboard-console-read-only
}

function sorcerer_url() {
  # Example: https://sorcerer.movableink-templates.com/data_sources/6dbb79b3b8460964?targetZip=71480
  local baseurl="https://sorcerer.movableink-templates.com/data_sources/"
  local url="$baseurl$1"
  
  # check if second argument is provided and not empty
  if [[ -n $2 ]]; then
    url="$url?$2"
  fi
  
  open "$url"
}

function ports () {
        local items="$(sudo lsof -n -i -P | tr -s " " | cut -d " " -f 2,9,10 | \grep "LISTEN")"
        printf "%-10s %-20s %s\n" "PID" "ADDRESS" "COMMAND"
        if [[ "${items}" == "" ]]
        then
                return
        fi
        while read item
        do
                local pid="$(echo "${item}" | awk '{print $1}')"
                local addr="$(echo "${item}" | awk '{print $2}')"
                local cmd="$(ps -o command "${pid}" | sed 1d)"
                printf "%-10s %-20s %s\n" "${pid}" "${addr}" "${cmd}"
        done <<< "${items}"
}

# Environment variables
export NODE_ENV="development"

# Path configuration
export PATH="$HOME/scripts:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Go private repositories
export GOPRIVATE=github.com/movableink

# Volta (Node.js version manager)
VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# ICU4C paths (for Rails)
export PATH="/opt/homebrew/opt/icu4c@76/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c@76/sbin:$PATH"
export PATH="/opt/homebrew/opt/icu4c@75/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c@75/sbin:$PATH"

# Set VSCode as the default editor
export EDITOR='code -w'

# FZF configuration
export FZF_DEFAULT_OPTS="--layout=reverse --height=10%"
export FORGIT_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height=50% --border --preview='bat --color=always {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# NVM (Node Version Manager) - if you use it instead of Volta
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"