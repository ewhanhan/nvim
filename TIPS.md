# TIPS.md

Custom keybindings and tips for this LazyVim configuration.

## Smart-Splits Navigation

Seamless navigation between Neovim splits AND tmux panes using the same keys.

| Key      | Action                      |
| -------- | --------------------------- |
| `Ctrl+h` | Move to left split/pane     |
| `Ctrl+j` | Move to lower split/pane    |
| `Ctrl+k` | Move to upper split/pane    |
| `Ctrl+l` | Move to right split/pane    |
| `Ctrl+\` | Move to previous split/pane |

**Resizing** (Alt/Meta + hjkl):

| Key     | Action             |
| ------- | ------------------ |
| `Alt+h` | Resize split left  |
| `Alt+j` | Resize split down  |
| `Alt+k` | Resize split up    |
| `Alt+l` | Resize split right |

The magic: these work across the tmux boundary. Press `Ctrl+l` in Neovim and it moves to the tmux pane on the right. The plugin auto-detects when you're at an edge and forwards the command to tmux.

## Buffer Navigation

- Use `H` and `L` if the buffer you want is visually close to where you are
- Otherwise, if the buffer is open, use `<leader>,`
- For other files, use `<leader><space>`
- Close buffers you no longer need with `<leader>bd`
- `<leader>ss` to quickly jump to a function in the current buffer
- `<C-o>`, `<C-i>` and `gd` to navigate the code
- Pin buffers with `<leader>bp` and delete all non-pinned buffers with `<leader>bP`
- Add TODOs in files you want to work on later but don't need now, then delete their buffers - git will track them

## Search & Resume

| Key          | Action                                           |
| ------------ | ------------------------------------------------ |
| `<leader>sR` | Resume last search (continue where you left off) |
| `<leader>sg` | Grep across project (live grep)                  |
| `<leader>sw` | Search word under cursor (or visual selection)   |
| `<leader>/`  | Grep (Root Dir) — same as `<leader>sg`           |
| `<leader>sb` | Buffer lines (search current buffer only)        |

## LSP Power Features

| Key          | Action                             |
| ------------ | ---------------------------------- |
| `gr`         | Find all references                |
| `gI`         | Go to implementation               |
| `gy`         | Go to type definition              |
| `K`          | Hover (press again to enter float) |
| `<leader>ss` | LSP symbols in buffer              |
| `<leader>sS` | LSP symbols in workspace           |

## Diagnostics Navigation

**View all diagnostics:**

| Key          | Action                            |
| ------------ | --------------------------------- |
| `<leader>xx` | Open diagnostics list (Trouble)   |
| `<leader>xX` | Buffer diagnostics only (Trouble) |
| `<leader>sd` | Fuzzy search diagnostics          |

**Navigate inline:**

| Key          | Action                         |
| ------------ | ------------------------------ |
| `]d` / `[d`  | Next/prev diagnostic (any)     |
| `]e` / `[e`  | Next/prev error only           |
| `]w` / `[w`  | Next/prev warning only         |
| `<leader>cd` | Show line diagnostics in float |

- After a refactor → `<leader>xx` to see all problems across files
- Fixing one file → `]e` to hop through errors
- Know what you're looking for → `<leader>sd` to search by message

## Surround Operations

```
ADD: ys{motion}{char}
  ysiw"      word        →  "word"
  ysiW'      wo.rd       →  'wo.rd'
  ys$)       to end      →  (to end)
  ys2w]      two words   →  [two words]
  ysiwb      word        →  (word)         b = )
  ysiwB      word        →  {word}         B = }
  ysiwr      word        →  [word]         r = ]
  ysiwa      word        →  <word>         a = >
  ysiwf      word        →  func(word)     prompts for func name
  ysiwt      word        →  <tag>word</tag> prompts for tag

DELETE: ds{char}
  ds"        "word"      →  word
  ds)        (expr)      →  expr
  dst        <div>x</div> → x
  dsf        func(x)     →  x
  dsq        'word'      →  word           q = nearest quote

CHANGE: cs{old}{new}
  cs"'       "word"      →  'word'
  cs)]       (list)      →  [list]
  cst<span>  <div>x</div> → <span>x</span>

VISUAL: S{char}
  viw S"     word        →  "word"
  vip S{     paragraph   →  { paragraph }
  V S<div>   line        →  <div>line</div>
```

## File Operations

| Key          | Action                  |
| ------------ | ----------------------- |
| `<leader>fw` | Write/save current file |
| `<leader>fW` | Write/save all files    |

## Snacks.nvim File Picker

Snacks.nvim replaces Telescope as the file picker. Key difference: **hidden files are visible by default** (both in file picker and explorer).

## Quick Reference

| Plugin        | Purpose                          | Key Feature                     |
| ------------- | -------------------------------- | ------------------------------- |
| smart-splits  | Tmux-aware navigation            | `C-hjkl` works across nvim/tmux |
| nvim-surround | Text surround operations         | `ys`, `ds`, `cs`, `S`           |
| snacks.nvim   | File picker (replaces Telescope) | Hidden files visible by default |
