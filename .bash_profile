# Set VSCode as the default editor
export EDITOR='code -w'
HISTCONTROL=ignoreboth:erasedups

# Load shell dotfiles
for file in ~/.{bash_prompt,bash_aliases,git-completion}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Git branch bash completion
if [ -f ~/.git-completion.sh ]; then
  . ~/.git-completion.sh

  # Add git completion to aliases
  __git_complete gco _git_checkout
  __git_complete gb _git_branch
fi

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

# FZF configuration
export FZF_DEFAULT_OPTS="--layout=reverse --height=10%"
export FORGIT_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height=50% --border --preview='bat --color=always {}'"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# MI CUSTOM JS
# NOTE: Add your MI tokens here after setup
# export MITOKEN="your-token-here"
# export MIDEVTOKEN="your-dev-token-here"
export MIUSER="jsigmon@movableink.com"

blueprint() {
  git clone git@github.com:movableink-clients/blueprint-client-repo.git
  echo "Renaming to $1" 
  mv blueprint-client-repo $1
  cd "$1"
  echo "Reseting remote origin to git@github.com:movableink-clients/$1.git"
  git remote set-url origin git@github.com:movableink-clients/$1.git 
}

freshPull() {
  git clone $1
}

# NVM (Node Version Manager) - if you use it instead of Volta
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Initialize RBENV if using Ruby
# eval "$(rbenv init -)"

source ~/.bashrc