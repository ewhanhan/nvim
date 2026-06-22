-- Markdown linting configuration
-- Forces markdownlint-cli2 to use global config from ~/.markdownlint-cli2.jsonc
return {
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters = {
        ['markdownlint-cli2'] = {
          prepend_args = {
            '--config',
            vim.fn.expand('~/.markdownlint-cli2.jsonc'),
          },
        },
      },
    },
  },

  -- Disable HTML comment concealing (render-markdown.nvim hides them by default)
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
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
