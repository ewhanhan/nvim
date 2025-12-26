return {
  {
    'folke/snacks.nvim',
    -- Disable redundant (cwd) keymaps since root_spec = { 'cwd' }
    keys = {
      { '<leader>E', false },
      { '<leader>fE', false },
      { '<leader>fF', false },
      { '<leader>sG', false },
      { '<leader>fR', false },
      { '<leader>sW', false, mode = { 'n', 'x' } },
      { '<leader>fT', false },
    },
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            hidden = true,
            ignored = false,
            auto_close = true,
          },
        },
      },
    },
  },
}
