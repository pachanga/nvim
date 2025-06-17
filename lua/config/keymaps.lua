-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>p", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>t", "<Esc>:FzfLua tags<CR>", { desc = "Find Tags" })

--- Finds the topmost VCS root directory starting from the given directory
--- Searches for .git (Git), .hg (Mercurial), or gamectl
--- @param start_dir string|nil Optional starting directory (defaults to current working directory)
--- @return string|nil Path to VCS root directory or nil if not found
local function find_proj_top_dir(start_dir)
  local vcs_markers = { '.git', '.hg', 'gamectl' }
  start_dir = start_dir or vim.loop.cwd()
  -- Normalize path separators and remove trailing slash
  start_dir = start_dir:gsub('[\\/]+$', '')
  local current_dir = start_dir
  local vcs_root = nil
  while true do
    -- Check for any VCS marker in current directory
    for _, marker in ipairs(vcs_markers) do
      local marker_path = current_dir .. '/' .. marker
      local stat = vim.loop.fs_stat(marker_path)
      if stat then
        vcs_root = current_dir
        break
      end
    end
    -- Get parent directory
    local parent_dir = current_dir:match('^(.*)[/\\][^/\\]+$')
    if not parent_dir or parent_dir == current_dir then
      break  -- Reached filesystem root
    end
    current_dir = parent_dir
  end
  return vcs_root
end

local rg_cmd = "rg --line-number --column --color=always -u -g !build/* -g !tags*"
vim.keymap.set("n", "<leader>g", function()
  require("fzf-lua").live_grep({ cmd = rg_cmd })
end, { desc = "Grep cwd" })
vim.keymap.set("n", "<leader>G", function()
  require("fzf-lua").live_grep({ cmd = rg_cmd, cwd = find_proj_top_dir() })
end, { desc = "Grep Project" })

vim.keymap.set("n", "<F3>", function()
  Snacks.picker.buffers({
     focus = "list", --start in normal mode
      win = {
        input = {
          keys = {
            --["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
          },
        },
      },})
end, { desc = "Show buffers" }
)

local function live_grep_cwd()
  require("fzf-lua").fzf_exec("fd --type d -I", {
  cwd = find_proj_top_dir(),
  actions = {
    ["default"] = function(sel, opts)
      require("fzf-lua").live_grep({ cwd = find_proj_top_dir() .. '/' .. sel[1] })
    end,
  },
})
end
vim.keymap.set("n", "<leader>fd", live_grep_cwd, {desc = "Grep Pick Dir"})

-- change command must not interfere with registers
vim.keymap.set('n', 'c', '"_c', { noremap = true })
vim.keymap.set('v', 'c', '"_c', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })
vim.keymap.set('v', 'C', '"_C', { noremap = true })

--let's remove these potentially conflicting with tmux mappings
vim.keymap.del("n", "<m-k>")
vim.keymap.del("n", "<m-j>")
vim.keymap.del("v", "<m-k>")
vim.keymap.del("v", "<m-j>")
vim.keymap.del("i", "<m-k>")
vim.keymap.del("i", "<m-j>")

-- Save on escape
--vim.keymap.set("n", "<Esc><Esc>", "<Esc>:up<CR>", { noremap = true })
