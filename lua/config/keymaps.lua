local map = vim.keymap.set
map('n', '<leader>fw', ':w<cr>', { desc = 'Write buffer / save file' })
map('n', '<leader>fW', ':wall<cr>', { desc = 'Write all buffer(s) / save all file(s)' })

-- In ~/.config/nvim/lua/config/keymaps.lua
if vim.g.vscode then
  -- ══════════════════════════════════════════════════════════════════════
  -- VSCODE KEYMAPPING CONFIGURATION
  -- ══════════════════════════════════════════════════════════════════════

  -- Helper function to apply mappings
  local function apply_mappings(mappings)
    for _, mapping in ipairs(mappings) do
      local modes, lhs, command, desc = mapping[1], mapping[2], mapping[3], mapping[4]
      -- Handle both string and table modes
      if type(modes) == 'string' then
        modes = { modes }
      end
      for _, mode in ipairs(modes) do
        map(mode, lhs, function()
          vim.fn.VSCodeNotify(command)
        end, { desc = desc })
      end
    end
  end

  -- ══════════════════════════════════════════════════════════════════════
  -- BUFFER MANAGEMENT MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  local buffer_mappings = {
    -- Switch to previous buffer
    { 'n', '<leader>bb', 'workbench.action.openPreviousRecentlyUsedEditor', 'Switch to Other Buffer' },
    { 'n', '<leader>`', 'workbench.action.openPreviousRecentlyUsedEditor', 'Switch to Other Buffer' },

    -- Close buffers
    { 'n', '<leader>bd', 'workbench.action.closeActiveEditor', 'Delete Buffer' },
    { 'n', '<leader>bo', 'workbench.action.closeOtherEditors', 'Delete Other Buffers' },
    { 'n', '<leader>bD', 'workbench.action.closeEditorsInGroup', 'Delete Buffer and Window' },

    -- Additional buffer commands
    { 'n', '<leader>ba', 'workbench.action.closeAllEditors', 'Close All Buffers' },
    { 'n', '<leader>bp', 'workbench.action.pinEditor', 'Pin Buffer' },
    { 'n', '<leader>bP', 'workbench.action.unpinEditor', 'Unpin Buffer' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- LSP/CODE ACTIONS MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  local code_mappings = {
    -- Code actions
    { { 'n', 'v' }, '<leader>ca', 'editor.action.quickFix', 'Code Action' },
    { { 'n', 'v' }, '<leader>cA', 'editor.action.sourceAction', 'Source Action' },

    -- Rename
    { 'n', '<leader>cr', 'editor.action.rename', 'Rename' },
    { 'n', '<leader>cR', 'workbench.files.action.showActiveFileInExplorer', 'Rename File' }, -- Then F2 in explorer

    -- CodeLens
    { { 'n', 'v' }, '<leader>cc', 'codelens.showLensesInCurrentLine', 'Run Codelens' },
    -- Format mappings
    { { 'n', 'v' }, '<leader>cf', 'editor.action.formatDocument', 'Format Document' },
    { 'v', '<leader>cf', 'editor.action.formatSelection', 'Format Selection' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- FILE EXPLORER MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  local explorer_mappings = {
    { 'n', '<leader>e', 'workbench.view.explorer', 'Explorer' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- TERMINAL MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  local terminal_mappings = {
    -- Terminal toggle
    { 'n', '<leader>ft', 'workbench.action.terminal.toggleTerminal', 'Terminal (Root Dir)' },
    { { 'n', 't' }, '<C-/>', 'workbench.action.terminal.toggleTerminal', 'Toggle Terminal' },
    { { 'n', 't' }, '<C-_>', 'workbench.action.terminal.toggleTerminal', 'Toggle Terminal (alt)' },

    -- Terminal management
    { 'n', '<leader>fT', 'workbench.action.terminal.new', 'New Terminal' },
    { 'n', '<leader>fs', 'workbench.action.terminal.split', 'Split Terminal' },
    { 'n', '<leader>fn', 'workbench.action.terminal.focusNext', 'Next Terminal' },
    { 'n', '<leader>fp', 'workbench.action.terminal.focusPrevious', 'Previous Terminal' },

    -- Terminal escape
    { 't', '<Esc><Esc>', 'workbench.action.focusActiveEditorGroup', 'Focus Editor' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- NAVIGATION MAPPINGS (FROM TERMINAL MODE)
  -- ══════════════════════════════════════════════════════════════════════
  local terminal_nav_mappings = {
    { 't', '<C-h>', 'workbench.action.focusLeftGroup', 'Focus left group' },
    { 't', '<C-j>', 'workbench.action.focusBelowGroup', 'Focus below group' },
    { 't', '<C-k>', 'workbench.action.focusAboveGroup', 'Focus above group' },
    { 't', '<C-l>', 'workbench.action.focusRightGroup', 'Focus right group' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- WINDOW MANAGEMENT MAPPINGS (<leader>w*)
  -- ══════════════════════════════════════════════════════════════════════
  local window_mappings = {
    -- ────────────────────────────────────────────────────────────────────
    -- SPLITTING
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>w-', 'workbench.action.splitEditorDown', 'Split Window Below' },
    { 'n', '<leader>w|', 'workbench.action.splitEditor', 'Split Window Right' },
    { 'n', '<leader>ws', 'workbench.action.splitEditorDown', 'Split Window Below' },
    { 'n', '<leader>wv', 'workbench.action.splitEditor', 'Split Window Right' },

    -- ────────────────────────────────────────────────────────────────────
    -- NAVIGATION (FOCUSING)
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>wh', 'workbench.action.focusLeftGroup', 'Go to Left Window' },
    { 'n', '<leader>wj', 'workbench.action.focusBelowGroup', 'Go to Lower Window' },
    { 'n', '<leader>wk', 'workbench.action.focusAboveGroup', 'Go to Upper Window' },
    { 'n', '<leader>wl', 'workbench.action.focusRightGroup', 'Go to Right Window' },

    -- Cycle through windows
    { 'n', '<leader>ww', 'workbench.action.focusNextGroup', 'Next Window' },
    { 'n', '<leader>wW', 'workbench.action.focusPreviousGroup', 'Previous Window' },

    -- ────────────────────────────────────────────────────────────────────
    -- MOVING EDITORS BETWEEN GROUPS
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>wH', 'workbench.action.moveEditorToLeftGroup', 'Move Editor Left' },
    { 'n', '<leader>wJ', 'workbench.action.moveEditorToBelowGroup', 'Move Editor Down' },
    { 'n', '<leader>wK', 'workbench.action.moveEditorToAboveGroup', 'Move Editor Up' },
    { 'n', '<leader>wL', 'workbench.action.moveEditorToRightGroup', 'Move Editor Right' },

    -- ────────────────────────────────────────────────────────────────────
    -- CLOSING
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>wd', 'workbench.action.closeEditorsInGroup', 'Delete Window' },
    { 'n', '<leader>wc', 'workbench.action.closeActiveEditor', 'Close Current Editor' },
    { 'n', '<leader>wq', 'workbench.action.closeEditorsInGroup', 'Close Window' },
    { 'n', '<leader>wo', 'workbench.action.closeOtherEditors', 'Close Other Editors' },
    { 'n', '<leader>wO', 'workbench.action.joinAllGroups', 'Close Other Windows' },

    -- ────────────────────────────────────────────────────────────────────
    -- RESIZING
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>w<', 'workbench.action.decreaseViewWidth', 'Decrease Width' },
    { 'n', '<leader>w>', 'workbench.action.increaseViewWidth', 'Increase Width' },
    { 'n', '<leader>w+', 'workbench.action.increaseViewHeight', 'Increase Height' },
    { 'n', '<leader>w_', 'workbench.action.decreaseViewHeight', 'Decrease Height' },
    { 'n', '<leader>w=', 'workbench.action.evenEditorWidths', 'Equal Sizes' },

    -- ────────────────────────────────────────────────────────────────────
    -- WINDOW ARRANGEMENT
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>wr', 'workbench.action.toggleEditorGroupLayout', 'Rotate Layout' },
    { 'n', '<leader>wf', 'workbench.action.focusActiveEditorGroup', 'Focus Editor' },
    { 'n', '<leader>wt', 'workbench.action.moveEditorToNewWindow', 'Move to New Window' },
    { 'n', '<leader>wT', 'workbench.action.newWindow', 'New Empty Window' },

    -- ────────────────────────────────────────────────────────────────────
    -- MAXIMIZING/ZOOMING
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>wm', 'workbench.action.toggleMaximizeEditorGroup', 'Toggle Maximize' },
    { 'n', '<leader>wz', 'workbench.action.toggleMaximizeEditorGroup', 'Zoom Toggle' },
    { 'n', '<leader>wM', 'workbench.action.maximizeEditorHideSidebar', 'Maximize Hide All' },

    -- ────────────────────────────────────────────────────────────────────
    -- TAB/EDITOR NAVIGATION WITHIN GROUP
    -- ────────────────────────────────────────────────────────────────────
    { 'n', '<leader>wn', 'workbench.action.nextEditor', 'Next Tab' },
    { 'n', '<leader>wp', 'workbench.action.previousEditor', 'Previous Tab' },
    { 'n', '<leader>w]', 'workbench.action.nextEditor', 'Next Tab' },
    { 'n', '<leader>w[', 'workbench.action.previousEditor', 'Previous Tab' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- QUICKFIX/PROBLEMS MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  local quickfix_mappings = {
    -- Toggle problems panel (VSCode's equivalent of quickfix)
    { 'n', '<leader>xq', 'workbench.actions.view.problems', 'Quickfix List' },

    -- Navigate problems/errors
    { 'n', '[q', 'editor.action.marker.prevInFiles', 'Previous Quickfix' },
    { 'n', ']q', 'editor.action.marker.nextInFiles', 'Next Quickfix' },

    -- Alternative navigation commands
    { 'n', '[e', 'editor.action.marker.prev', 'Previous Error' },
    { 'n', ']e', 'editor.action.marker.next', 'Next Error' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- GIT MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  local git_mappings = {
    -- Git status/changes
    { 'n', '<leader>gg', 'workbench.view.scm', 'Git Status' },
    { 'n', '<leader>gG', 'git.openChange', 'Git Changes' },
  }

  -- ══════════════════════════════════════════════════════════════════════
  -- APPLY ALL MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  apply_mappings(explorer_mappings)
  apply_mappings(terminal_mappings)
  apply_mappings(terminal_nav_mappings)
  apply_mappings(window_mappings)
  apply_mappings(code_mappings)
  apply_mappings(buffer_mappings)
  apply_mappings(quickfix_mappings)
  apply_mappings(git_mappings)

  -- ══════════════════════════════════════════════════════════════════════
  -- SPECIAL WINDOW NUMBER MAPPINGS
  -- ══════════════════════════════════════════════════════════════════════
  for i = 1, 9 do
    map('n', '<leader>w' .. i, function()
      vim.fn.VSCodeNotify('workbench.action.openEditorAtIndex' .. i)
    end, { desc = 'Go to Tab ' .. i })
  end

  -- Special handling for rename file (two-step process)
  vim.keymap.set('n', '<leader>cR', function()
    vim.fn.VSCodeNotify('workbench.files.action.showActiveFileInExplorer')
    vim.defer_fn(function()
      vim.fn.VSCodeNotify('renameFile')
    end, 100)
  end, { desc = 'Rename File' })
end
