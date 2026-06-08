return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        taplo = { enabled = false },
        tombi = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        toml = { 'tombi' },
      },
    },
  },
}
