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



# Initialize RBENV
# eval "$(rbenv init -)"

export PATH="/usr/local/opt/node@8/bin:$PATH"


# MI CUSTOM JS
export MITOKEN="o4jpXjS-GFFhclVd6J9OZ2AEOtZxqcbjPxryyN6NNgQvZ6TvLTZlxg"
export MIDEVTOKEN="o4jpXjS-GFFhclVd6J9OZ2AEOtZxqcbjPxryyN6NNgQvZ6TvLTZlxg"
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

source ~/.bashrc