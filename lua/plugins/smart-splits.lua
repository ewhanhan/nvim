return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  keys = {
    -- Navigation
    {
      '<C-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Move to Left Split/Pane',
      mode = { 'n', 't' },
    },
    {
      '<C-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Move to Lower Split/Pane',
      mode = { 'n', 't' },
    },
    {
      '<C-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Move to Upper Split/Pane',
      mode = { 'n', 't' },
    },
    {
      '<C-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Move to Right Split/Pane',
      mode = { 'n', 't' },
    },
    {
      '<C-\\>',
      function()
        require('smart-splits').move_cursor_previous()
      end,
      desc = 'Move to Previous Split/Pane',
      mode = { 'n', 't' },
    },
    -- Resizing (also in terminal mode for snacks terminals)
    {
      '<M-h>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize Split Left',
      mode = { 'n', 't' },
    },
    {
      '<M-j>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize Split Down',
      mode = { 'n', 't' },
    },
    {
      '<M-k>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize Split Up',
      mode = { 'n', 't' },
    },
    {
      '<M-l>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize Split Right',
      mode = { 'n', 't' },
    },
  },
}
