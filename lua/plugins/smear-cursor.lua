-- sphamba/smear-cursor.nvim: animated cursor trail rendered with text glyphs.
-- Independent of g.snacks_animate (which stays off). Toggle with <leader>uM
-- or :SmearCursorToggle if it ever gets in the way (e.g. screen recording)
return {
  {
    'sphamba/smear-cursor.nvim',
    event = 'VeryLazy',
    config = function(_, opts)
      require('smear_cursor').setup(opts)
      -- <leader>uS (the obvious pick) is LazyVim's snacks scroll toggle and
      -- gets re-mapped on VeryLazy, so it can't be reliably overridden here
      Snacks.toggle({
        name = 'Smear Cursor',
        get = function()
          return require('smear_cursor').enabled
        end,
        set = function(state)
          require('smear_cursor').enabled = state
        end,
      }):map('<leader>uM')
    end,
    opts = {
      -- Ghostty rasterizes legacy computing symbols natively, so the smear
      -- renders at sub-cell resolution instead of coarse block characters
      legacy_computing_symbols_support = true,
      -- Snappier than defaults (0.6 / 0.45 / 0.85): the trail catches up
      -- quickly so motions never feel laggy
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      damping = 0.95,
      distance_stop_animating = 0.5,
    },
  },
}
