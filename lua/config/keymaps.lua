local map = vim.keymap.set
map("n", "<leader>fw", ":w<cr>", { desc = "Write buffer / save file" })
map("n", "<leader>fW", ":wall<cr>", { desc = "Write all buffer(s) / save all file(s)" })
