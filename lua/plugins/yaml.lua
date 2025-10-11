return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local yaml_settings = opts.servers.yamlls.settings.yaml
      yaml_settings.format = vim.tbl_deep_extend('force', yaml_settings.format or {}, {
        enable = true,
        singleQuote = true,
      })

      return opts
    end,
  },
}
