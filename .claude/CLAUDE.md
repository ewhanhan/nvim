# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

LazyVim-based Neovim configuration with tmux integration.

**Plugin sources**: `~/.local/share/nvim/lazy/<plugin>/` — check actual source before claiming what a plugin does. LazyVim defaults are in `LazyVim/lua/lazyvim/plugins/`.

## Development Commands

```bash
# Plugin management
:Lazy                    # Plugin manager UI
:Lazy sync              # Install/update plugins
:LazyExtras             # Manage language extras

# Shell alias
nvimU                   # Headless plugin update

# Code quality
./scripts/check.lua     # All checks: stylua --check, selene, lua-language-server types
stylua lua/             # Format Lua (80 col, 2 spaces, single quotes), from repo root
selene lua/             # Lint Lua, from repo root

# Keymap inspection (trace <Lua N: path:line> to source)
nvim --headless -c 'map' -c 'qa!' 2>&1
```

## Architecture

### Key Design Decisions

**Root Detection Disabled**: `g.root_spec = { 'cwd' }` forces cwd as root. This makes `(cwd)` keymap variants redundant - they're disabled in `snacks.lua` and `keymaps.lua`.

**Smart-splits Non-Lazy**: `lua/plugins/smart-splits.lua` uses `lazy = false` - critical for immediate tmux navigation. Don't change this.

**Snacks Replaces Telescope**: File picker via snacks.nvim with hidden files visible by default.

**Snacks File Explorer**: The `snacks_explorer` extra is the file explorer (`<leader>e`/`E`/`fe`/`fE`), with hidden files visible by default. The dashboard `e` key opens it via `Snacks.explorer()`.

**Project-Local Config**: `opt.exrc = true` enables `.nvim.lua`/`.lazy.lua` files per project.

## Plugin Customization Pattern

All plugins in `lua/plugins/` follow LazyVim's override pattern:

```lua
-- Extend existing plugin
---@type LazySpec
return {
  {
    'plugin/name',
    ---@module 'plugin'
    ---@type plugin.Config  -- the plugin's own opts type
    opts = { ... },  -- Merged with defaults
  },
}

-- Use opts function when you need to access/modify parent defaults
---@type LazySpec
return {
  {
    'plugin/name',
    ---@module 'plugin'
    ---@param opts plugin.Config
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'new' })
      return opts
    end,
  },
}
```

**Merging rules**: `opts`, `keys`, `cmd`, `event`, `ft`, `dependencies` extend defaults. All other properties (`config`, `init`, `lazy`, etc.) replace entirely. Lists _inside_ `opts` are replaced, not appended (lazy.nvim only merges non-list tables), so append to a list with an `opts` function.

**Type annotations**: every spec file puts `---@type LazySpec` above its `return`, and every non-empty `opts` gets the plugin's published opts type (check the plugin's README or `---@class` definitions; prefer a type whose fields are all optional, such as `grug.far.OptionsOverride`). `---@module` makes lazydev load that plugin's types in the editor. lua_ls catches wrong value types but never misspelled keys. `./scripts/check.lua` type-checks the whole repo, with every installed plugin's types.

**Disabling keymaps**: Set to `false`. Normal mode keymaps don't need a mode specified; multi-mode keymaps must match exactly:

```lua
keys = {
  { '<leader>x', false },                    -- Normal mode (no mode needed)
  { '<leader>y', false, mode = { 'n', 'x' } }, -- Multi-mode (must match original)
}
```

Use `keys = {}` to disable all keymaps, or `keys = function() return {...} end` to replace them entirely. The same function pattern works for `keys`, `ft`, `event`, and `cmd`.

## Key Integrations

| Integration   | Config Location                | Notes                                                      |
| ------------- | ------------------------------ | ---------------------------------------------------------- |
| Tmux nav      | `smart-splits.lua`             | `Ctrl+h/j/k/l` across nvim/tmux                            |
| Markdown lint | `markdown.lua`                 | Uses global `~/.markdownlint.jsonc`                        |
| Surround      | `surround.lua` (nvim-surround) | Visual `S` overrides flash; use `<c-space>` for treesitter |

## File Formatting Standards

| Type | Tool   | Config                                                        |
| ---- | ------ | ------------------------------------------------------------- |
| Lua  | stylua | 80 col, 2 spaces, single quotes preferred                     |
| Lua  | selene | vim std (`vim.yml`), mixed tables allowed                     |
| Lua  | lua_ls | `.luarc.json`; library added by lazydev / `scripts/check.lua` |
| YAML | yamlls | Single quotes enforced                                        |

## Critical Constraints

- **Don't lazy-load smart-splits** - breaks tmux integration
- **Keep `root_spec = { 'cwd' }`** - many keymaps depend on this
- **Plugin versions unlocked** - uses latest, not pinned versions
