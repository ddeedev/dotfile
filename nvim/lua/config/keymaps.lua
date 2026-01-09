-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", { desc = "Toggle Autosave (Global)" })

-- FLOG git graph
-- vim.api.nvim_set_keymap("n", "<leader>gi", ":Flog<CR>", {})
--
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle float<CR>", { desc = "Float File Explorer", silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":Neotree toggle right<CR>", { desc = "Right File Explorer", silent = true })

-- toggle copilot
-- Function to toggle Copilot
function _G.toggle_copilot()
  local copilot_status = vim.fn["copilot#Enabled"]()
  if copilot_status == 1 then
    vim.cmd("Copilot disable")
    vim.notify("Copilot disabled", vim.log.levels.INFO, { title = "Copilot" })
  else
    vim.cmd("Copilot enable")
    vim.notify("Copilot enabled", vim.log.levels.INFO, { title = "Copilot" })
  end
end

-- Toggle Copilot with <leader>ce
vim.api.nvim_set_keymap("n", "<leader>ce", ":lua _G.toggle_copilot()<CR>", { desc = "Toggle Copilot", silent = false })

-- UNCOMMEND THIS TO USE smart-splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
