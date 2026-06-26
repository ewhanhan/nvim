local active_colorscheme = 'gruvbox-material' -- 'gruvbox' or 'gruvbox-material' SYNC(theme)

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
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_transparent_background = 1

      -- Keep StatusLine transparent so the empty bar lualine draws over snacks
      -- pickers (disabled filetypes) stays invisible, while lualine's own
      -- sections (bg_statusline1) remain opaque.
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup(
          'custom_highlights_gruvboxmaterial',
          {}
        ),
        pattern = 'gruvbox-material',
        callback = function()
          local config = vim.fn['gruvbox_material#get_configuration']()
          local palette = vim.fn['gruvbox_material#get_palette'](
            config.background,
            config.foreground,
            config.colors_override
          )
          vim.fn['gruvbox_material#highlight'](
            'StatusLine',
            palette.fg1,
            palette.none
          )
        end,
      })
    end,
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = active_colorscheme,
    },
  },
}
