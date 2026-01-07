return {
  {
    'nvim-lualine/lualine.nvim',
    opts = function(_, opts)
      -- Options
      opts.options.component_separators = ''
      opts.options.section_separators = { left = '', right = '' }

      vim.list_extend(opts.options.disabled_filetypes.statusline, {
        'snacks_terminal',
        'snacks_picker_input',
        'snacks_picker_list',
        'yazi',
      })

      -- Relocate filetype from lualine_c to lualine_y with bubble separators
      for i, c in ipairs(opts.sections.lualine_c) do
        local name = type(c) == 'table' and c[1] or c
        if name == 'filetype' then
          table.remove(opts.sections.lualine_c, i)
          break
        end
      end

      -- Sections
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
            return ('Ln %d, Col %d'):format(vim.fn.line('.'), vim.fn.col('.'))
          end,
          separator = {
            left = '',
            right = '',
          },
        },

        {
          'filetype',
          separator = {
            left = '',
            right = '',
          },
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
