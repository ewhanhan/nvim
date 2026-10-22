-- folke/lazydev.nvim: lua_ls types for the Neovim API and plugins.
-- LazyVim loads lazy.nvim's types only in buffers that mention `LazyVim`;
-- also load them for spec files annotated `---@type LazySpec`.
-- An opts function, not a table: lazy.nvim replaces lists when merging opts,
-- so a `library` table here would drop LazyVim's entries.
---@type LazySpec
return {
  {
    'folke/lazydev.nvim',
    ---@module 'lazydev'
    ---@param opts lazydev.Config
    opts = function(_, opts)
      table.insert(opts.library, { path = 'lazy.nvim', words = { 'LazySpec' } })
      return opts
    end,
  },
}
