local map = vim.keymap.set
map("n", "<leader>fw", ":w<cr>", { desc = "Write buffer / save file" })
map("n", "<leader>fW", ":wall<cr>", { desc = "Write all buffer(s) / save all file(s)" })
-- vscode style shifting
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selected lines up" })
