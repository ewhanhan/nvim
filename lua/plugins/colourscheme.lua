local active_colorscheme = 'gruvbox-material' -- 'gruvbox' or 'gruvbox-material'

return {
  {
    'ellisonleao/gruvbox.nvim',
    enabled = active_colorscheme == 'gruvbox',
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    enabled = active_colorscheme == 'gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = active_colorscheme,
    },
  },
}
