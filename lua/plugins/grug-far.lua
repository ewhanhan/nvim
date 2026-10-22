-- MagicDuck/grug-far.nvim: project-wide search and replace (<leader>sr).
-- Moves the frequent actions off `<localleader>` (`\`) chords. String keymaps
-- bind normal and insert mode, so the replacement applies straight from input.
--   <C-s>  replace all
--   <C-q>  send results to quickfix (same key as the snacks picker)
--   q      close (normal mode)
-- The rest keep their `\` defaults; `g?` lists them.
--
-- <C-s> is Replace, not Sync All: sync writes the results area, which lags
-- the inputs by the 500ms search debounce, so an immediate sync can write a
-- stale preview. Replace reads the inputs directly. Sync All (edit or delete
-- result lines, then apply) stays on `\s`.
-- Avoid <M-CR>: Ghostty sends it for Shift+Enter.
return {
  {
    'MagicDuck/grug-far.nvim',
    keys = {
      -- LazyVim's <leader>sr without the `*.<ext>` files filter prefill.
      {
        '<leader>sr',
        function()
          require('grug-far').open({ transient = true })
        end,
        mode = { 'n', 'x' },
        desc = 'Search and Replace',
      },
    },
    opts = {
      keymaps = {
        replace = '<C-s>',
        qflist = '<C-q>',
        close = { n = 'q' },
      },
    },
  },
}
