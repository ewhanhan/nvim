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
---@type LazySpec
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
    init = function()
      -- VS Code-style Alt+C/W/R toggles, each adding or removing an rg flag
      -- in the Flags input. Case stays exact by default: rg can't preserve
      -- case on replace, so a looser match rewrites `User` as `user`.
      -- <M-r> adds --fixed-strings, so ON means regex is off.
      local toggles = {
        ['<M-c>'] = '--smart-case',
        ['<M-w>'] = '--word-regexp',
        ['<M-r>'] = '--fixed-strings',
      }
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('grug_far_toggles', {}),
        pattern = 'grug-far',
        callback = function(ev)
          for lhs, flag in pairs(toggles) do
            vim.keymap.set({ 'n', 'i' }, lhs, function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              local before = vim.fn.getline(cursor[1])
              local inst = require('grug-far').get_instance(0)
              if not inst then
                return
              end
              local on = inst:toggle_flags({ flag })[1]
              -- toggle_flags rewrites the Flags line, which pushes a cursor
              -- on it down into Paths. Put it back, at the end of the line.
              local after = vim.fn.getline(cursor[1])
              if after ~= before then
                cursor[2] = #after
              end
              vim.api.nvim_win_set_cursor(0, cursor)
              vim.notify('grug-far: ' .. flag .. (on and ' ON' or ' OFF'))
            end, { buffer = ev.buf, desc = 'Toggle ' .. flag })
          end
        end,
      })
    end,
    ---@module 'grug-far'
    ---@type grug.far.OptionsOverride
    opts = {
      keymaps = {
        replace = '<C-s>',
        qflist = '<C-q>',
        close = { n = 'q' },
      },
    },
  },
}
