-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>p", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>t", "<Esc>:FzfLua tags<CR>", { desc = "Find Tags" })

local rg_cmd = "rg --line-number --column --color=always -u -g !build/* -g !tags*"
vim.keymap.set("n", "<leader>g", function()
  require("fzf-lua").live_grep({ cmd = rg_cmd })
end, { desc = "Grep cwd" })
vim.keymap.set("n", "<leader>G", function()
  require("fzf-lua").live_grep({ cmd = rg_cmd, cwd = LazyVim.root() })
end, { desc = "Grep Project" })

--vim.keymap.set("n", "<leader>g", "<Esc>:FzfLua grep_project<CR>", { desc = "Grep Project" })
vim.keymap.set("n", "<F3>", function()
  Snacks.picker.buffers()
end, { desc = "Show buffers" })

-- Save on escape
--vim.keymap.set("n", "<Esc><Esc>", "<Esc>:up<CR>", { noremap = true })
