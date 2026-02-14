-- === YAZI ===
--
-- Primary file explorer using yazi terminal file manager.
-- Falls back to snacks_explorer when yazi is not installed.
--
-- Keymaps:
--   <leader>e     Explorer Yazi (current file)
--   <leader>E     Explorer Yazi (cwd)
--   <leader>fe    Explorer Yazi (current file)
--   <leader>fE    Explorer Yazi (cwd)
--   <leader>-     Open yazi in cwd
--   <C-Up>        Resume last yazi session

return {
  {
    'mikavilpas/yazi.nvim',
    enabled = vim.fn.executable('yazi') == 1,
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      { '<leader>e', '<cmd>Yazi<cr>', desc = 'Explorer Yazi' },
      { '<leader>E', '<cmd>Yazi cwd<cr>', desc = 'Explorer Yazi (cwd)' },
      { '<leader>fe', '<cmd>Yazi<cr>', desc = 'Explorer Yazi' },
      { '<leader>fE', '<cmd>Yazi cwd<cr>', desc = 'Explorer Yazi (cwd)' },
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi cwd<cr>',
        desc = 'Open yazi in cwd',
      },
      {
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume last yazi session',
      },
    },
    init = function()
      -- Prevent netrw from loading since yazi handles directories
      vim.g.loaded_netrwPlugin = 1
    end,
    ---@type YaziConfig
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
}
