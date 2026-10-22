---@type LazySpec
return {
  {
    'neovim/nvim-lspconfig',
    ---@module 'lazyvim.plugins.lsp'
    ---@param opts PluginLspOpts
    opts = function(_, opts)
      local yaml_settings = opts.servers.yamlls.settings.yaml
      -- PluginLspOpts types `settings` loosely (`.format` would resolve to
      -- string.format); narrow it to nvim-lspconfig's yamlls settings type.
      ---@cast yaml_settings _.lspconfig.settings.yamlls.Yaml
      yaml_settings.format =
        vim.tbl_deep_extend('force', yaml_settings.format or {}, {
          enable = true,
          singleQuote = true,
        })

      return opts
    end,
  },
}
