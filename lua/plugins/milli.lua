-- Amansingh-afk/milli.nvim: animated ASCII splash on the snacks dashboard.
local SPLASH = 'dancer'

return {
  {
    'Amansingh-afk/milli.nvim',
    -- Not lazy: the adapter registers a SnacksDashboardOpened autocmd that must
    -- exist before the dashboard opens at VimEnter.
    lazy = false,
    config = function()
      require('milli').snacks({ splash = SPLASH, loop = true })
    end,
  },
  {
    'folke/snacks.nvim',
    opts = function(_, opts)
      -- pcall: load() errors on a typo'd/renamed SPLASH (runtime.lua:39), which
      -- would otherwise throw inside snacks' opts pipeline and break the whole
      -- dashboard. On failure we fall back to LazyVim's default header.
      local ok, splash = pcall(require('milli').load, { splash = SPLASH })
      local frame = ok and splash.frames and splash.frames[1]
      if frame then
        opts.dashboard = opts.dashboard or {}
        opts.dashboard.preset = opts.dashboard.preset or {}
        opts.dashboard.preset.header = table.concat(frame, '\n')
      end
      return opts
    end,
  },
}
