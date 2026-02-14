return {
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      -- Explorer replacements (previously snacks explorer)
      { '<leader>e', '<cmd>Yazi<cr>', desc = 'Explorer (Yazi)' },
      { '<leader>fe', '<cmd>Yazi<cr>', desc = 'Explorer (Yazi)' },
      -- Yazi.nvim defaults
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at current file',
      },
      { '<leader>cw', '<cmd>Yazi cwd<cr>', desc = 'Open yazi in cwd' },
      {
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume last yazi session',
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
      -- Cap floating window width at 90 columns and center horizontally
      hooks = {
        before_opening_window = function(win_opts)
          win_opts.width = math.min(90, vim.o.columns - 6)
          win_opts.col = math.floor((vim.o.columns - win_opts.width) / 2)
        end,
      },
    },
    init = function()
      -- Prevent netrw from loading since yazi handles directories
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
