local map = vim.keymap.set

map("n", "<leader><leader>", "<C-^>", { desc = "Previous file" })
map("n", "<leader>/", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic details" })
