-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode == nil then
  vim.g.vscode = vim.env.VSCODE_NEOVIM == "1"
end

require("config.lazy")
