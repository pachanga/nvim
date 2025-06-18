-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.snacks_animate = false
vim.opt.relativenumber = false
vim.g.root_spec = { ".git" }
vim.g.autoformat = false
vim.opt.wrap = true

if vim.fn.executable("rg") then
  -- if ripgrep installed, use that as a grepper
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

--vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--  pattern = "*.bhl",
--  command = "setfiletype go",
--})

--vim.g.lazyvim_php_lsp = "intelephense"

vim.lsp.enable("bhl")
vim.lsp.config("bhl", {
  cmd = { os.getenv("HOME") .. "/dev/bhl/bhl", "lsp", "--log-file=" .. os.getenv("HOME") .. "/tmp/bhl.lsp" },
  filetypes = { "bhl" },
  root_markers = { "bhl.proj" },
  settings = {
    --bhl = {
    --  log_level = "debug",
    --},
  },
})
vim.cmd([[ au BufNewFile,BufRead /*.bhl setf bhl ]])
