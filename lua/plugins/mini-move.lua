-- Override mini.move to free <M-h> and <M-l> for smart-splits resize
return {
  {
    'echasnovski/mini.move',
    opts = {
      mappings = {
        -- Disable horizontal (conflicts with smart-splits resize)
        left = '',
        right = '',
        line_left = '',
        line_right = '',
        -- Keep vertical movement
        down = '<M-j>',
        up = '<M-k>',
        line_down = '<M-j>',
        line_up = '<M-k>',
      },
    },
  },
}
