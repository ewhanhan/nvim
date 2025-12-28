-- === FLASH ===
--
-- Disable visual mode `S` to let nvim-surround handle it.
-- Flash's treesitter-select is still available via `<C-space>` in visual mode.
--
return {
  {
    'folke/flash.nvim',
    keys = {
      { 'S', mode = { 'x', 'o' }, false },
    },
  },
}
