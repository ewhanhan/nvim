-- lua_ls requires VIMRUNTIME in its initial settings to resolve the `vim`
-- global. lazydev.nvim provides this dynamically via workspace/configuration,
-- but lua_ls does not apply library additions from that handler when the
-- initial workspace.library is unset.
return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local lua_ws = opts.servers.lua_ls.settings.Lua.workspace
      lua_ws.library = lua_ws.library or {}
      table.insert(lua_ws.library, vim.env.VIMRUNTIME .. '/lua')

      return opts
    end,
  },
}
