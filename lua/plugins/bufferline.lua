return {
  {
    'akinsho/bufferline.nvim',
    opts = function(_, opts)
      opts.options.style_preset = require('bufferline').style_preset.minimal
      opts.highlights = function(config)
        local hl = {}
        for name in pairs(config.highlights) do
          if name:match('_selected$') then
            hl[name] = { bg = { attribute = 'bg', highlight = 'CursorLine' } }
          end
        end
        return hl
      end
    end,
  },
}
