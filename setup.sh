#!/bin/bash

# New Mac Setup Script
# Run this script to set up a new macOS development environment

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo_info "Starting macOS development environment setup..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo_info "Homebrew already installed"
fi

# Install packages from Brewfile
echo_info "Installing packages from Brewfile..."
brew bundle install --file="$SCRIPT_DIR/Brewfile"

# Install oh-my-zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo_info "Oh My Zsh already installed"
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo_info "Powerlevel10k already installed"
fi

# Install FZF
echo_info "Setting up FZF..."
$(brew --prefix)/opt/fzf/install --all --no-bash --no-fish

# Install Volta for Node.js management
if ! command -v volta &> /dev/null; then
    echo_info "Installing Volta..."
    curl https://get.volta.sh | bash
else
    echo_info "Volta already installed"
fi

# Create backup of existing dotfiles
echo_info "Creating backup of existing dotfiles..."
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# List of dotfiles to backup and link
DOTFILES=(
    ".zshrc"
    ".bash_profile"
    ".bashrc"
    ".bash_aliases"
    ".bash_prompt"
    ".gitconfig"
    ".gitexcludes"
    ".p10k.zsh"
    ".fzf.zsh"
    ".fzf.bash"
)

# Backup and create symlinks
for file in "${DOTFILES[@]}"; do
    if [ -f "$HOME/$file" ] || [ -L "$HOME/$file" ]; then
        echo_info "Backing up existing $file..."
        mv "$HOME/$file" "$BACKUP_DIR/" 2>/dev/null || true
    fi
    
    if [ -f "$SCRIPT_DIR/$file" ]; then
        echo_info "Creating symlink for $file..."
        ln -sf "$SCRIPT_DIR/$file" "$HOME/$file"
    fi
done

# VSCode settings
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_DIR" ]; then
    echo_info "Setting up VSCode configuration..."
    
    # Backup existing VSCode settings
    if [ -f "$VSCODE_DIR/settings.json" ]; then
        cp "$VSCODE_DIR/settings.json" "$BACKUP_DIR/vscode_settings.json"
    fi
    if [ -f "$VSCODE_DIR/keybindings.json" ]; then
        cp "$VSCODE_DIR/keybindings.json" "$BACKUP_DIR/vscode_keybindings.json"
    fi
    if [ -d "$VSCODE_DIR/snippets" ]; then
        cp -r "$VSCODE_DIR/snippets" "$BACKUP_DIR/vscode_snippets"
    fi
    
    # Link VSCode settings
    ln -sf "$SCRIPT_DIR/VSCode/settings.json" "$VSCODE_DIR/settings.json"
    ln -sf "$SCRIPT_DIR/VSCode/keybindings.json" "$VSCODE_DIR/keybindings.json"
    
    # Link snippets
    mkdir -p "$VSCODE_DIR/snippets"
    for snippet in "$SCRIPT_DIR/VSCode/snippets"/*.json; do
        if [ -f "$snippet" ]; then
            filename=$(basename "$snippet")
            ln -sf "$snippet" "$VSCODE_DIR/snippets/$filename"
        fi
    done
else
    echo_warn "VSCode directory not found. Install VSCode first, then re-run this script."
fi

# Create necessary directories
echo_info "Creating necessary directories..."
mkdir -p "$HOME/scripts"

# Set up Git completion for bash (if not already present)
if [ ! -f "$HOME/.git-completion.sh" ]; then
    echo_info "Downloading git-completion.sh..."
    curl -o "$HOME/.git-completion.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi

# Important reminders
echo ""
echo_warn "=== IMPORTANT REMINDERS ==="
echo_warn "1. Add your sensitive tokens to the following files:"
echo_warn "   - ~/.zshrc: Add your OPENAI_ACCESS_TOKEN"
echo_warn "   - ~/.bash_profile: Add your MITOKEN and MIDEVTOKEN"
echo ""
echo_warn "2. Configure your AWS credentials:"
echo_warn "   Run: aws configure"
echo ""
echo_warn "3. Set up SSH keys for GitHub:"
echo_warn "   ssh-keygen -t ed25519 -C \"your_email@example.com\""
echo_warn "   pbcopy < ~/.ssh/id_ed25519.pub"
echo_warn "   Then add the key to GitHub: https://github.com/settings/keys"
echo ""
echo_warn "4. Install VSCode extensions from Brewfile:"
echo_warn "   The extensions are listed in the Brewfile but need manual installation"
echo ""
echo_warn "5. If using iTerm2, import your preferences"
echo ""

echo_info "Setup complete! Backup of your original dotfiles saved to: $BACKUP_DIR"
echo_info "Please restart your terminal or run: source ~/.zshrc"