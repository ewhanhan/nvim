-- === WHICH-KEY ===
--
-- Hide infrequently-used or redundant keymaps from the popup.
-- Mappings still work; they just don't clutter the menu.
--
return {
  {
    'folke/which-key.nvim',
    opts = {
      filter = function(mapping)
        -- Keymaps to hide from which-key popup (mappings still work)
        -- Leader resolves to space in lhs
        local hidden_keys = {
          ' D', -- Toggle DBUI
          ' K', -- Keywordprg
          ' l', -- Lazy
          ' L', -- LazyVim Changelog
          ' ?', -- Buffer Keymaps (which-key)
          ' :', -- Command History
          ' |', -- Split horizontal
          ' -', -- Split vertical
        }
        return not vim.tbl_contains(hidden_keys, mapping.lhs)
      end,
    },
  },
}
