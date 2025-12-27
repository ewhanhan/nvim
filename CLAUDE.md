# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

LazyVim-based Neovim configuration with tmux integration and VSCode compatibility.

## Development Commands

```bash
# Plugin management
:Lazy                    # Plugin manager UI
:Lazy sync              # Install/update plugins
:LazyExtras             # Manage language extras

# Shell alias
nvimU                   # Headless plugin update

# Code quality (run from repo root)
stylua lua/             # Format Lua (80 col, 2 spaces, single quotes)
selene lua/             # Lint Lua
```

## Architecture

### Dual-Editor Mode

`init.lua` detects VSCode via `vim.env.VSCODE` and loads appropriate keymaps:

- **Terminal Neovim**: Full config with smart-splits tmux integration
- **VSCode Neovim**: Minimal config with `lua/config/vscode-keymaps.lua`

### Key Design Decisions

**Root Detection Disabled**: `g.root_spec = { 'cwd' }` forces cwd as root. This makes `(cwd)` keymap variants redundant - they're disabled in `snacks.lua` and `keymaps.lua`.

**Smart-splits Non-Lazy**: `lua/plugins/smart-splits.lua` uses `lazy = false` - critical for immediate tmux navigation. Don't change this.

**Snacks Replaces Telescope**: File picker/explorer via snacks.nvim with hidden files visible by default.

**Project-Local Config**: `opt.exrc = true` enables `.nvim.lua`/`.lazy.lua` files per project.

## Plugin Customization Pattern

All plugins in `lua/plugins/` follow LazyVim's override pattern:

```lua
-- Extend existing plugin
return {
  {
    'plugin/name',
    opts = { ... },  -- Merged with defaults
  },
}

-- Use opts function when you need to access/modify parent defaults
return {
  {
    'plugin/name',
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'new' })
      return opts
    end,
  },
}
```

**Merging rules**: `opts`, `keys`, `cmd`, `event`, `ft`, `dependencies` extend defaults. All other properties (`config`, `init`, `lazy`, etc.) replace entirely.

**Disabling keymaps**: Set to `false`. Normal mode keymaps don't need a mode specified; multi-mode keymaps must match exactly:

```lua
keys = {
  { '<leader>x', false },                    -- Normal mode (no mode needed)
  { '<leader>y', false, mode = { 'n', 'x' } }, -- Multi-mode (must match original)
}
```

Use `keys = {}` to disable all keymaps, or `keys = function() return {...} end` to replace them entirely. The same function pattern works for `keys`, `ft`, `event`, and `cmd`.

## Key Integrations

| Integration   | Config Location      | Notes                               |
| ------------- | -------------------- | ----------------------------------- |
| Tmux nav      | `smart-splits.lua`   | `Ctrl+h/j/k/l` across nvim/tmux     |
| VSCode        | `vscode-keymaps.lua` | LazyVim parity for VSCode Neovim    |
| Wakatime      | `wakatime.lua`       | Non-lazy for accurate tracking      |
| Markdown lint | `markdown.lua`       | Uses global `~/.markdownlint.jsonc` |

## File Formatting Standards

| Type | Tool   | Config                                    |
| ---- | ------ | ----------------------------------------- |
| Lua  | stylua | 80 col, 2 spaces, single quotes preferred |
| Lua  | selene | vim std, mixed tables allowed             |
| YAML | yamlls | Single quotes enforced                    |

## Critical Constraints

- **Don't lazy-load smart-splits** - breaks tmux integration
- **Keep `root_spec = { 'cwd' }`** - many keymaps depend on this
- **VSCode keymaps are separate** - changes to `keymaps.lua` won't affect VSCode mode
- **Plugin versions unlocked** - uses latest, not pinned versions
