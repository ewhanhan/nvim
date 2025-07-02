return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        exclude = { ".git", "node_modules" },
        sources = {
          files = {
            hidden = true,
            ignored = true,
          },
          explorer = {
            hidden = true,
            ignored = true,
            auto_close = false,
          },
          grep = {
            hidden = true,
            ignored = true,
          },
          grep_word = {
            hidden = true,
            ignored = true,
          },
          grep_buffers = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
