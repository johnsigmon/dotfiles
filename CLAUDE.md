# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environments, containing shell configurations (bash/zsh), git settings, and VSCode customizations. The repository uses a flat structure with configuration files in the root directory.

## Common Development Tasks

### Shell Configuration Updates
- Primary shell: Zsh with oh-my-zsh framework (`.zshrc`)
- Bash configurations are modular: `.bash_profile` (main), `.bash_aliases` (aliases/functions), `.bash_prompt` (git-aware prompt)
- When modifying shell configs, test in both bash and zsh environments

### Git Configuration
- Global git config in `.gitconfig` includes user identity and Movable Ink specific URL rewrites
- Global gitignore patterns in `.gitexcludes`

### VSCode Settings
- Settings, keybindings, and snippets located in `VSCode/` directory
- JavaScript and YAML snippets available for rapid development
- Uses Prettier as default formatter with specific configurations

## Architecture & Patterns

### Modular Shell Configuration
The bash setup follows a modular pattern where `.bash_profile` sources additional files:
- `.bash_prompt`: Git-aware prompt with status indicators
- `.bash_aliases`: Command aliases and utility functions
- External completions are loaded conditionally (serverless, git-completion)

### Development Environment Dependencies
This configuration assumes these tools are installed:
- **oh-my-zsh**: Zsh framework with plugins (git, colored-man-pages, npm, yarn, forgit)
- **fzf**: Fuzzy finder with custom preview settings using `bat`
- **nvm**: Node Version Manager for Node.js version management
- **exa**: Modern `ls` replacement used in aliases
- **bat**: Syntax-highlighted cat alternative

### Work-Specific Customizations
Contains Movable Ink specific configurations:
- Deployment aliases (`dcjs`, `nsf`)
- Environment variables for MI tokens and user info
- Git URL rewriting for `movableink` and `movableink-preview` repositories
- Blueprint project creation function (`new_blueprint`)

## Important Considerations

### Security Notice
The `.bash_profile` contains sensitive tokens and credentials that should be handled carefully. When making changes, never expose these values in commits or logs.

### Platform Specific
This configuration is macOS-specific and uses paths like `/Users/jsigmon/`. Path references may need adjustment when working with these files.

### No Installation Automation
This repository lacks automated setup scripts. Configuration files must be manually linked or copied to their appropriate locations in the home directory.