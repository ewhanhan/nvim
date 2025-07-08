return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        exclude = {
          -- Version control
          ".git",
          -- Dependencies
          "node_modules",
          "vendor",
          -- Build outputs
          "dist",
          "build",
          "out",
          ".next",
          "target",
          -- Caches
          "__pycache__",
          ".pytest_cache",
          ".mypy_cache",
          ".turbo",
          -- Test artifacts
          "coverage",
        },
        sources = {
          explorer = {
            auto_close = false,
          },
        },
      },
    },
  },
}
