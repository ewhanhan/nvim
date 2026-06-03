-- gbprod/substitute.nvim: replace a text object with the register contents.
-- Uses the conflict-free `g`-prefix (mnemonic: "go substitute"); the plugin's
-- own `s`/`ss`/`S` defaults collide with flash.nvim, and `gr*` is core LSP.
--   gsi(   substitute inside parens with register (clipboard under unnamedplus)
--   gsa"   substitute around the quotes
--   gss    substitute the whole line
--   gS     substitute to end of line
--   {visual} gs  substitute the selection
return {
  {
    'gbprod/substitute.nvim',
    keys = {
      {
        'gs',
        function()
          require('substitute').operator()
        end,
        desc = 'Substitute w/ register',
      },
      {
        'gss',
        function()
          require('substitute').line()
        end,
        desc = 'Substitute line',
      },
      {
        'gS',
        function()
          require('substitute').eol()
        end,
        desc = 'Substitute to EOL',
      },
      {
        'gs',
        function()
          require('substitute').visual()
        end,
        mode = 'x',
        desc = 'Substitute selection',
      },
    },
    opts = {},
  },
}
