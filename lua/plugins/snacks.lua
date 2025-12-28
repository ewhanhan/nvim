return {
  {
    'folke/snacks.nvim',
    -- Disable redundant (cwd) keymaps since root_spec = { 'cwd' }
    -- Note: <leader>fT is a core keymap, disabled in config/keymaps.lua
    keys = {
      { '<leader>E', false },
      { '<leader>fE', false },
      { '<leader>fF', false },
      { '<leader>sG', false },
      { '<leader>fR', false },
      { '<leader>sW', false, mode = { 'n', 'x' } },
    },
    opts = {
      picker = {
        actions = {
          copy_file_path = function(_, item, _)
            if not item then return end

            local file = item.file or item.text
            if not file then return end

            local vals = {
              ['BASENAME'] = vim.fn.fnamemodify(file, ':t:r'),
              ['EXTENSION'] = vim.fn.fnamemodify(file, ':t:e'),
              ['FILENAME'] = vim.fn.fnamemodify(file, ':t'),
              ['PATH'] = file,
              ['PATH (CWD)'] = vim.fn.fnamemodify(file, ':.'),
              ['PATH (HOME)'] = vim.fn.fnamemodify(file, ':~'),
              ['URI'] = vim.uri_from_fname(file),
            }

            local options = vim.tbl_filter(function(val)
              return vals[val] ~= ''
            end, vim.tbl_keys(vals))
            table.sort(options)

            vim.ui.select(options, {
              prompt = 'Copy to clipboard:',
              format_item = function(i) return ('%s: %s'):format(i, vals[i]) end,
            }, function(choice)
              if choice then
                vim.fn.setreg('+', vals[choice])
                Snacks.notify.info('Yanked: ' .. vals[choice])
              end
            end)
          end,
        },
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            hidden = true,
            ignored = false,
            auto_close = true,
            win = {
              list = { keys = { ['Y'] = 'copy_file_path', ['<C-y>'] = 'copy_file_path' } },
            },
          },
        },
        win = {
          list = { keys = { ['Y'] = 'copy_file_path', ['<C-y>'] = 'copy_file_path' } },
          input = { keys = { ['<C-y>'] = { 'copy_file_path', mode = { 'n', 'i' } } } },
        },
      },
    },
  },
}
