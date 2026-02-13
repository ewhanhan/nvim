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
    },
    init = function()
      -- Prevent netrw from loading since yazi handles directories
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
