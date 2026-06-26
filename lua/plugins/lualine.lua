return {
  {
    'nvim-lualine/lualine.nvim',
    opts = function(_, opts)
      -- Options
      opts.options.component_separators = ''
      opts.options.section_separators = { left = '', right = '' }

      vim.list_extend(opts.options.disabled_filetypes.statusline, {
        'snacks_terminal',
        'snacks_picker_input',
        'snacks_picker_list',
      })

      -- Sections
      -- lualine_c: keep LazyVim's root_dir + diagnostics; filetype is moved to
      -- lualine_y, and pretty_path shows a dot for modified buffers.
      local icons = LazyVim.config.icons
      opts.sections.lualine_c = {
        LazyVim.lualine.root_dir(),
        {
          'diagnostics',
          always_visible = true,
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { LazyVim.lualine.pretty_path({ modified_sign = ' ●' }) },
      }

      opts.sections.lualine_a = {
        {
          'mode',
          icon = '',
        },
      }

      opts.sections.lualine_x = {}
      opts.sections.lualine_y = {
        {
          function()
            return ('Ln %d, Col %d'):format(
              vim.fn.line('.'),
              vim.fn.charcol('.')
            )
          end,
        },
        {
          'filetype',
          padding = 2,
        },
      }

      opts.sections.lualine_z = {}

      vim.list_extend(opts.extensions, {
        'trouble',
        'quickfix',
        'mason',
        'nvim-dap-ui',
        'man',
      })
      return opts
    end,
  },
}
