---@type LazySpec
return {
  {
    'neovim/nvim-lspconfig',
    ---@module 'lazyvim.plugins.lsp'
    ---@type PluginLspOpts
    opts = {
      servers = {
        taplo = { enabled = false },
        tombi = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        toml = { 'tombi' },
      },
    },
  },
}
