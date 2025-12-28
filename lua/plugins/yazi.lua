-- === YAZI ===
--
-- <f1>: show the help menu
-- <c-v>: open the selected file(s) in vertical splits
-- <c-x>: open the selected file(s) in horizontal splits
-- <c-t>: open the selected file(s) in new tabs
-- <c-q>: send the selected file(s) to the quickfix list
-- <c-s>: search in the current yazi directory
return {
  {
    'mikavilpas/yazi.nvim',
    version = '*',
    enabled = vim.fn.executable('yazi') == 1,
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      { '-', '<cmd>Yazi<cr>', desc = 'Open yazi at current file' },
      { '<leader>fy', '<cmd>Yazi<cr>', desc = 'Open yazi at current file' },
      { '<c-up>', '<cmd>Yazi toggle<cr>', desc = 'Resume last yazi session' },
    },
    ---@type YaziConfig | {}
    opts = {
      -- keep snacks_explorer for directory browsing
      open_for_directories = false,
      keymaps = {
        show_help = '?',
      },
      integrations = {
        -- <C-s> in yazi greps within the current directory using snacks.picker
        -- benefit: scoped search without leaving the file manager
        grep_in_directory = 'snacks.picker',
        grep_in_selected_files = 'snacks.picker',
      },
    },
  },
}
