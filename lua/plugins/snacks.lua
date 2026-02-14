-- === SNACKS ===
--
-- Custom actions (this config):
--   Y           copy_file_path        Select format to yank (cwd, home, uri, etc.)
--   D           diff                  Diff two Tab-selected files
--
-- Picker workflows:
--   MULTI-SELECT: Tab (toggle + next), S-Tab (toggle + prev), <C-a> (all)
--   OPEN SPLIT:   <C-v> (vsplit), <C-s> (hsplit), <C-t> (tab)
--   QUICKFIX:     Tab files → <C-q> (send to qflist)
--   SHOW PATH:    <C-g> (print path to cmdline)
--   HELP:         ? (show all keybindings)
--
-- Disabled: fF, sG, fR, sW (redundant with root_spec = cwd)
-- Hidden files: enabled by default in picker
--
return {
  {
    'folke/snacks.nvim',
    keys = {
      { '<leader>fF', false },
      { '<leader>sG', false },
      { '<leader>fR', false },
      { '<leader>sW', false, mode = { 'n', 'x' } },
    },
    opts = {
      styles = {
        lazygit = {
          width = 0,
          height = 0,
          wo = {
            winhighlight = 'Normal:Normal',
          },
        },
      },
      picker = {
        actions = {
          copy_file_path = function(_, item, _)
            if not item then
              return
            end

            local file = item.file or item.text
            if not file then
              return
            end

            local vals = {
              ['BASENAME'] = vim.fn.fnamemodify(file, ':t:r'),
              ['EXTENSION'] = vim.fn.fnamemodify(file, ':t:e'),
              ['FILENAME'] = vim.fn.fnamemodify(file, ':t'),
              ['PATH'] = file,
              ['PATH (CWD)'] = vim.fn.fnamemodify(file, ':.'),
              ['PATH (HOME)'] = vim.fn.fnamemodify(file, ':~'),
              ['URI'] = vim.uri_from_fname(vim.fn.fnamemodify(file, ':p')),
            }

            local options = vim.tbl_filter(function(val)
              return vals[val] ~= ''
            end, vim.tbl_keys(vals))
            table.sort(options)

            vim.ui.select(options, {
              prompt = 'Copy to clipboard:',
              format_item = function(i)
                return ('%s: %s'):format(i, vals[i])
              end,
            }, function(choice)
              if choice then
                vim.fn.setreg('+', vals[choice])
                Snacks.notify.info('Yanked: ' .. vals[choice])
              end
            end)
          end,

          diff = function(picker, _, _)
            local sel = picker:selected()
            if #sel < 2 then
              Snacks.notify.warn(
                'Select two files for diff (use Tab to select)'
              )
              return
            end
            local file1, file2 = sel[1].file, sel[2].file
            if not file1 or not file2 then
              Snacks.notify.warn('Selected items must be files')
              return
            end
            picker:close()
            vim.cmd('tabnew ' .. vim.fn.fnameescape(file1))
            vim.cmd('vert diffsplit ' .. vim.fn.fnameescape(file2))
            Snacks.notify.info('Diffing ' .. file1 .. ' vs ' .. file2)
          end,
        },
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          grep = {
            hidden = true,
            ignored = false,
          },
          grep_word = {
            hidden = true,
            ignored = false,
          },
        },
        win = {
          input = {
            keys = {
              ['Y'] = 'copy_file_path',
              ['D'] = 'diff',
            },
          },
          list = {
            keys = {
              ['Y'] = 'copy_file_path',
              ['D'] = 'diff',
            },
          },
        },
      },
    },
  },
}
