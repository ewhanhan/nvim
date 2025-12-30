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
}
