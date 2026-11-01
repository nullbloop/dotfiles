local map = vim.keymap.set

map({ "n", "v", "o" }, "<A-j>", "}", { desc = "Next paragraph" })
map({ "n", "v", "o" }, "<A-k>", "{", { desc = "Previous paragraph" })
map("n", "<leader>m", "%", { desc = "Match bracket" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>",  { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>",  { desc = "Close others" })
map("n", "gh", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
map("n", "gl", "<cmd>tabnext<cr>",     { desc = "Next tab" })
map("n", "<leader>tj", "<cmd>tabnext<cr>",     { desc = "Next tab" })
map("n", "<leader>tk", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
map("n", "<leader>tl", "<cmd>tabnext #<cr>",   { desc = "Last tab" })
for i = 1, 9 do
        map("n", "<leader>t" .. i, "<cmd>tabnext " .. i .. "<cr>", { desc = "Tab " .. i })
end
map("n", "<leader>t0", "<cmd>tabnext $<cr>",   { desc = "Last tab" })
map("n", "<leader>t,", "<cmd>tabmove -1<cr>",  { desc = "Move tab left" })
map("n", "<leader>t.", "<cmd>tabmove +1<cr>",  { desc = "Move tab right" })
