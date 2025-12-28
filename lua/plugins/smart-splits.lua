return {
  'mrjones2014/smart-splits.nvim',
  lazy = false, -- CRITICAL: Must load immediately for tmux integration
  opts = {
    -- === IGNORE SETTINGS ===
    -- Ignored buffer types (only affects resizing, not navigation)
    ignored_buftypes = {
      'nofile', -- bufferline, floating windows
      'quickfix', -- trouble.nvim, quickfix lists
      'prompt', -- input prompts, terminal prompts
    },
    -- Ignored filetypes (only affects resizing, not navigation)
    ignored_filetypes = {
      'NvimTree', -- file explorer
      'Trouble', -- trouble.nvim
      'qf', -- quickfix
      'help', -- help windows
      'man', -- man pages
      'dapui_watches',
      'dapui_breakpoints',
      'dapui_scopes',
      'dapui_console',
      'dapui_stacks', -- DAP UI
      'snacks_explorer', -- snacks.nvim explorer
      'snacks_notif', -- snacks.nvim notifications
      'snacks_terminal', -- snacks.nvim terminal
      'snacks_dashboard', -- snacks.nvim dashboard
      'snacks_win', -- snacks.nvim windows
      'snacks_picker_list', -- snacks.nvim picker/telescope lists
    },

    -- === NAVIGATION BEHAVIOR ===
    -- Default resize amount (can be overridden with count, e.g., "3<M-h>")
    default_amount = 3,

    -- Behavior when cursor is at an edge and moving towards that edge:
    -- 'wrap' => Wrap to opposite side (perfect for tmux users)
    -- 'split' => Create a new split in the desired direction
    -- 'stop' => Do nothing
    at_edge = 'wrap',

    -- Behavior when current window is floating:
    -- 'previous' => Focus previous window and perform action (better for LazyVim)
    -- 'mux' => Always forward action to multiplexer
    float_win_behavior = 'previous',

    -- === CURSOR BEHAVIOR ===
    -- When moving left/right, keep cursor on same screen row regardless of line numbers
    move_cursor_same_row = false,

    -- Whether cursor should follow buffer when swapping buffers between windows
    cursor_follows_swapped_bufs = false,

    -- Disable multiplexer navigation when current pane is zoomed
    disable_multiplexer_nav_when_zoomed = true,

    -- === PERFORMANCE OPTIMIZATION ===
    -- Ignore these autocmd events during smart-splits computations for better performance
    ignored_events = {
      'BufEnter',
      'WinEnter',
    },

    -- === LOGGING ===
    log_level = 'info', -- 'trace'|'debug'|'info'|'warn'|'error'|'fatal'
  },

  -- === KEYMAPS ===
  -- NOTE: These keymaps work in normal mode and won't conflict with your
  -- existing terminal mode VSCode integration mappings (<C-h/j/k/l> in terminal mode)
  keys = {
    -- === NAVIGATION ===
    {
      '<C-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Move to Left Split/Pane',
      mode = 'n',
    },
    {
      '<C-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Move to Lower Split/Pane',
      mode = 'n',
    },
    {
      '<C-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Move to Upper Split/Pane',
      mode = 'n',
    },
    {
      '<C-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Move to Right Split/Pane',
      mode = 'n',
    },
    {
      '<C-\\>',
      function()
        require('smart-splits').move_cursor_previous()
      end,
      desc = 'Move to Previous Split/Pane',
      mode = 'n',
    },
    -- === RESIZING ===
    -- NOTE: On macOS, you may need to configure your terminal to send Alt as Meta
    -- Alternative keybinds if Alt doesn't work: <leader>rh/rj/rk/rl
    {
      '<M-h>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize Split Left',
      mode = 'n',
    },
    {
      '<M-j>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize Split Down',
      mode = 'n',
    },
    {
      '<M-k>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize Split Up',
      mode = 'n',
    },
    {
      '<M-l>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize Split Right',
      mode = 'n',
    },
  },
}
