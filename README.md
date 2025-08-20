# John's Dotfiles

Personal dotfiles repository for macOS development environment setup.

## Quick Start

```bash
# Clone this repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the setup script
./setup.sh
```

## What's Included

### Shell Configuration
- **Zsh**: Primary shell with Oh My Zsh and Powerlevel10k theme
- **Bash**: Modular configuration with custom prompt and aliases
- **FZF**: Fuzzy finder integration for both shells

### Development Tools
- **Git**: Configured with aliases, colors, and Movable Ink specific settings
- **VSCode**: Settings, keybindings, and custom snippets
- **Homebrew**: Brewfile with all development dependencies
- **Volta**: Node.js version management

### Custom Functions
- `search-this`: Recursive grep with file extension filtering
- `kssh`: Quick kubectl exec into pods
- `klogs`: Follow kubectl logs
- `getpods`: List resque pods
- `get-aws-creds`: Refresh AWS SSO credentials
- `sorcerer_url`: Open Movable Ink Sorcerer URLs
- `ports`: Show listening ports with process info
- `blueprint`: Create new MI blueprint projects

## Manual Setup Steps

After running `setup.sh`, you'll need to:

### 1. Add Sensitive Tokens
Edit the following files and add your tokens:
- `~/.zshrc`: Add your `OPENAI_ACCESS_TOKEN`
- `~/.bash_profile`: Add your `MITOKEN` and `MIDEVTOKEN`

### 2. Configure AWS
```bash
aws configure
```

### 3. Set up SSH Keys for GitHub
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
pbcopy < ~/.ssh/id_ed25519.pub
# Add the key to: https://github.com/settings/keys
```

### 4. Install VSCode Extensions
The Brewfile contains VSCode extensions that need manual installation through VSCode.

### 5. iTerm2 Configuration
If using iTerm2, import your preferences from backup.

## Directory Structure

```
.
├── .zshrc                # Zsh configuration
├── .bash_profile         # Bash login shell config
├── .bashrc              # Bash non-login shell config
├── .bash_aliases        # Bash aliases and functions
├── .bash_prompt         # Git-aware bash prompt
├── .gitconfig           # Git configuration
├── .gitexcludes         # Global gitignore
├── .p10k.zsh           # Powerlevel10k config
├── .fzf.zsh            # FZF config for Zsh
├── .fzf.bash           # FZF config for Bash
├── Brewfile            # Homebrew packages
├── setup.sh            # Automated setup script
├── VSCode/             # VSCode configurations
│   ├── settings.json
│   ├── keybindings.json
│   └── snippets/
└── README.md           # This file
```

## Customization

### Environment Variables
Key environment variables are set in:
- `.zshrc` for Zsh
- `.bash_profile` for Bash

### Path Configuration
Custom paths are added for:
- Homebrew (`/opt/homebrew/bin`)
- Scripts (`~/scripts`)
- Volta (`~/.volta/bin`)
- ICU4C (for Rails development)
- LibPQ (PostgreSQL tools)

### Work-Specific (Movable Ink)
This configuration includes MI-specific tools and aliases:
- Git URL rewrites for MI repos
- Blueprint project creation
- Sorcerer URL helper
- AWS SSO profiles

## Updating

To update your dotfiles:
1. Pull the latest changes: `git pull`
2. Re-run the setup script: `./setup.sh`
3. Restart your terminal

## Backup

The setup script automatically backs up existing dotfiles to:
`~/dotfiles_backup_YYYYMMDD_HHMMSS/`

## Requirements

- macOS (Apple Silicon or Intel)
- Command Line Tools: `xcode-select --install`
- Internet connection for downloading dependencies

## Troubleshooting

### Zsh Theme Not Loading
Run: `p10k configure` to reconfigure Powerlevel10k

### FZF Not Working
Re-install FZF: `$(brew --prefix)/opt/fzf/install`

### VSCode Settings Not Applied
Ensure VSCode is installed and restart it after running setup

### Permission Issues
Make sure scripts are executable: `chmod +x setup.sh`

## License

Personal use only. Feel free to fork and customize for your own needs.