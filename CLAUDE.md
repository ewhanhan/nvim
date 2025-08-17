# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **LazyVim-based Neovim configuration** that provides a sophisticated development environment with comprehensive language support, tmux integration, and VSCode compatibility.

## Key Architecture

### LazyVim Foundation
- **Base Framework**: Built on LazyVim (https://lazyvim.org) for structured plugin management
- **Plugin Manager**: Uses lazy.nvim for efficient lazy loading and performance optimization
- **Modular Structure**: Configuration split between `config/` (core settings) and `plugins/` (plugin customizations)

### Language Support
Extensive language ecosystem through LazyVim extras (39 active):
- **Languages**: Angular, C/C++, CMake, Docker, Git, Go, Java, JSON, Markdown, Prisma, Python, Rust, SQL, Svelte, Tailwind, LaTeX, TOML, TypeScript, Vue, YAML
- **Development Tools**: DAP debugging, ESLint, testing framework, refactoring tools
- **Editor Enhancements**: LuaSnip snippets, mini-comment, mini-surround, yanky, mini-move, Snacks explorer/picker

### Python Environment Management
**Dedicated Python Environment**: Uses uv-managed environment at `~/.config/nvim-python/`
```bash
# Setup commands (if needed):
uv venv ~/.config/nvim-python
uv pip install --python ~/.config/nvim-python/bin/python neovim
```
- **Configuration**: Python host automatically configured in `lua/config/options.lua`
- **Verification**: Use `:checkhealth provider.python` to verify setup

## Key Features & Integrations

### Smart-splits for Tmux Integration
**Critical Integration**: Must load immediately (not lazy) for seamless tmux navigation
- **Navigation**: `Ctrl+h/j/k/l` works across both Neovim splits and tmux panes
- **Resizing**: `Alt+h/j/k/l` for window resizing
- **Wrap Behavior**: Configured for tmux users with edge wrapping enabled

### Snacks.nvim Enhancements
- **File Picker**: Shows hidden and ignored files by default
- **Explorer**: Auto-closes and displays hidden files
- **Performance**: Replaces default telescope for better performance

### VSCode Compatibility
**Comprehensive VSCode Integration**: 200+ keybinding mappings for seamless dual-editor workflow
- **Buffer Management**: `<leader>b*` commands mapped to VSCode editor actions
- **Window Management**: `<leader>w*` commands for VSCode group operations
- **Terminal Integration**: `<leader>f*` commands for VSCode terminal
- **Code Actions**: `<leader>c*` commands for LSP operations
- **Navigation**: Consistent `Ctrl+h/j/k/l` in terminal mode

### Theme & Visual Consistency
- **Gruvbox Theme**: Coordinated with terminal and tmux for visual consistency
- **Performance**: Animations disabled (`vim.g.snacks_animate = false`)
- **Custom Status**: Lualine configuration with location section

## Development Commands

### Plugin Management
```bash
# Neovim commands:
:Lazy                    # Open plugin manager interface
:Lazy update            # Update all plugins
:Lazy sync              # Synchronize plugins (install missing, update existing)
:Lazy clean             # Remove unused plugins

# Shell commands:
nvimU                   # Update Neovim plugins headlessly (from shell)
```

### Health Checks
```bash
:checkhealth                  # Run comprehensive health checks
:checkhealth provider.python  # Check Python provider specifically
:checkhealth lazy             # Check Lazy.nvim status
```

### LazyVim Extras Management
```bash
:LazyExtras             # Manage LazyVim extras (language support, tools)
:LazyVim                # Access LazyVim information and utilities
```

### Code Quality Tools
**Lua Linting & Formatting**:
- **selene.toml**: Lua linting configuration with vim std and mixed table allowance
- **stylua.toml**: Lua formatting (2 spaces, 120 column width, sort requires enabled)

### Testing & Debugging
```bash
# Testing framework integration:
:Neotest run              # Run nearest test
:Neotest run file         # Run tests in current file
:Neotest summary          # View test summary

# DAP debugging:
<leader>db                # Toggle breakpoint
<leader>dr                # Start/continue debugging
<leader>ds                # Step over
<leader>di                # Step into
<leader>do                # Step out
```

## Configuration Structure

### Core Configuration Files
- `init.lua` - Entry point with VSCode detection and lazy loading
- `lua/config/lazy.lua` - Lazy.nvim setup with performance optimizations
- `lua/config/options.lua` - Python host, performance settings, editor options
- `lua/config/keymaps.lua` - Custom keybindings and extensive VSCode mappings
- `lua/config/autocmds.lua` - Auto commands
- `lazyvim.json` - LazyVim extras configuration (39 active)

### Plugin Customizations
- `lua/plugins/smart-splits.lua` - Tmux integration with comprehensive configuration
- `lua/plugins/snacks.lua` - Enhanced file picker and explorer settings
- `lua/plugins/colourscheme.lua` - Gruvbox theme configuration
- `lua/plugins/wakatime.lua` - Time tracking (not lazy-loaded)
- `lua/plugins/yaml.lua` - Single-quote YAML formatting
- `lua/plugins/lualine.lua` - Status line customization (location section, cleaner layout)
- `lua/plugins/tabout.lua` - Smart tab completion with quote/bracket escaping
- `lua/plugins/disabled.lua` - Plugin disabling (currently empty)

### Snippets
- **Custom JavaScript/TypeScript snippets** in `snippets/` directory
- **Managed through LazyVim LuaSnip integration**
- **Key snippets**: `log` (console.log), `function`, `for`/`forof`/`foreach`, `if`/`ifelse`, `switch`, `while`, `trycatch`, `settimeout`/`setinterval`

## Performance Optimizations

### Startup Performance
- **Disabled Runtime Plugins**: gzip, tarPlugin, tohtml, tutor, zipPlugin
- **Lazy Loading**: Most plugins except smart-splits (immediate tmux integration)
- **Modern APIs**: Uses `vim.uv` over deprecated `vim.loop`

### Development Optimizations
- **Plugin Checker**: Enabled with notifications disabled for background updates
- **Version Management**: Plugin versions unlocked for latest features
- **Install Fallbacks**: Colorscheme fallbacks (tokyonight, gruvbox)

## Working with This Configuration

### Modification Patterns
- **Plugin Additions**: Create new files in `lua/plugins/` directory
- **Core Settings**: Modify files in `lua/config/` directory
- **Language Support**: Use `:LazyExtras` to add/remove language support
- **VSCode Mappings**: Extend `lua/config/keymaps.lua` VSCode section

### Performance Considerations
- Keep smart-splits as non-lazy for immediate tmux integration
- Use conditional loading patterns for optional integrations
- Test startup time impact of new plugins
- Maintain VSCode compatibility when adding keybindings

### Integration Points
- **Tmux**: Smart-splits provides seamless navigation with `Ctrl+h/j/k/l` and `Alt+h/j/k/l` for resizing
- **Terminal**: WezTerm integration through tmux
- **Development**: Python environment isolation with uv at `~/.config/nvim-python/`
- **Time Tracking**: WakaTtime integration for development metrics
- **Formatting**: YAML single-quote preference, Lua formatting standards
- **Tab Completion**: Tabout.nvim enhances tab behavior for quotes/brackets with escape sequences
- **Version Control**: Plugin versions locked in `lazy-lock.json` for reproducible builds

## Important Notes

### Critical Configuration Patterns
- **Smart-splits**: Must remain `lazy = false` for immediate tmux integration
- **VSCode Detection**: Configuration automatically adapts when `vim.env.VSCODE` is detected
- **Autocmds**: Minimal custom autocmds - relies primarily on LazyVim defaults
- **Plugin Locking**: Use `lazy-lock.json` to maintain stable plugin versions across installations