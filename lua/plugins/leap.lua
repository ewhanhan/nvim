-- LazyVim's `editor.leap` extra wires `s`/`S`/`gs` via leap's deprecated
-- `add_default_mappings()`, which points them at <Plug> targets the codeberg
-- fork renamed, so they silently no-op. Replace the config with leap's current
-- README default (bidirectional `s`). Remove once LazyVim#6756 lands.
return {
  {
    url = 'https://codeberg.org/andyg/leap.nvim.git',
    keys = function()
      return {
        { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap' },
        { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from window' },
      }
    end,
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      local function map(lhs, rhs, desc)
        vim.keymap.set({ 'n', 'x', 'o' }, lhs, rhs, { desc = desc })
      end
      map('s', '<Plug>(leap)', 'Leap')
      map('gs', '<Plug>(leap-from-window)', 'Leap from window')
    end,
  },
}
