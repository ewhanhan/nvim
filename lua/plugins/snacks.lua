return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
          },
          explorer = {
            hidden = true,
            ignored = true,
            auto_close = true,
          },
          grep = {
            hidden = false,
            ignored = false,
          },
          grep_word = {
            hidden = false,
            ignored = false,
          },
          grep_buffers = {
            hidden = false,
            ignored = false,
          },
        },
      },
    },
  },
}
