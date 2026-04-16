return {
  {
    'coder/claudecode.nvim',
    enabled = vim.fn.executable('claude') == 1,
    opts = {
      terminal = {
        split_width_percentage = 0.50,
      },
      diff_opts = {
        open_in_new_tab = true,
      },
    },
  },
}
