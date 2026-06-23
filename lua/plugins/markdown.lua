-- Markdown linting configuration
-- Forces markdownlint-cli2 to use global config from ~/.markdownlint-cli2.jsonc
return {
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = function(_, opts)
      -- Only force the global config when it actually exists, so markdown
      -- linting doesn't break on machines where the dotfile isn't present.
      local config = vim.fs.normalize('~/.markdownlint-cli2.jsonc')
      if vim.uv.fs_stat(config) then
        opts.linters = opts.linters or {}
        opts.linters['markdownlint-cli2'] = vim.tbl_deep_extend(
          'force',
          opts.linters['markdownlint-cli2'] or {},
          { prepend_args = { '--config', config } }
        )
      end
      return opts
    end,
  },

  -- render-markdown.nvim tweaks
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      -- In-process LSP completions for callouts ([!NOTE]) and checkbox states.
      -- Rides on blink.cmp (LazyVim's default engine), no extra source needed.
      completions = { lsp = { enabled = true } },
      -- Repeat the quote bar on wrapped lines of block quotes & callouts.
      -- The window options are scoped to rendered view so they don't leak
      -- globally; they revert to 'default' in insert/visual mode.
      quote = { repeat_linebreak = true },
      win_options = {
        showbreak = { default = '', rendered = '  ' }, -- align past the '▋ '
        breakindent = { default = false, rendered = true },
        breakindentopt = { default = '', rendered = '' },
      },
      -- Don't conceal HTML comments (render-markdown hides them by default).
      html = {
        comment = {
          conceal = false,
        },
      },
    },
  },

  -- Browser preview: replace the abandoned markdown-preview.nvim (master frozen
  -- since 2023, requires a Node/yarn build) with the actively-maintained,
  -- pure-Lua live-preview.nvim.
  { 'iamcco/markdown-preview.nvim', enabled = false },
  {
    'brianhuster/live-preview.nvim',
    dependencies = { 'folke/snacks.nvim' },
    cmd = 'LivePreview',
    keys = {
      {
        '<leader>cp',
        '<cmd>LivePreview start<cr>',
        ft = { 'markdown', 'markdown.mdx' },
        desc = 'Markdown Preview (live-preview)',
      },
      {
        '<leader>cP',
        '<cmd>LivePreview close<cr>',
        ft = { 'markdown', 'markdown.mdx' },
        desc = 'Stop Markdown Preview',
      },
    },
    opts = {
      picker = 'snacks.picker',
      sync_scroll = true,
    },
    config = function(_, opts)
      require('livepreview.config').set(opts)
    end,
  },
}
