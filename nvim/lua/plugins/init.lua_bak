-- Define environment variables at the top of your plugin file
local in_tmux = os.getenv("TMUX") ~= nil
local in_wezterm = os.getenv("TERM_PROGRAM") == "WezTerm"
local use_navigator = not in_tmux or in_wezterm

-- The combined array of plugin specifications
return {
  -- ----------------------------------------------------------------------
  -- 1. Navigator.nvim (Used when NOT in tmux OR when in WezTerm)
  -- ----------------------------------------------------------------------
  {
    "numToStr/Navigator.nvim",
    -- Only load if we are not in tmux, OR if we are specifically in WezTerm
    cond = use_navigator,
    config = function()
      require("Navigator").setup({
        disable_on_zoom = true,
        mux = in_wezterm and "wezterm" or "none",
      })

      -- You do not need to manually set keymaps for WezTerm if mux = "wezterm" is set.
      -- Navigator.nvim handles passing the keys to the terminal multiplexer
      -- automatically if the `mux` option is set correctly.
      -- Your manual keymap block is likely redundant or potentially confusing
      -- for Navigator.nvim's internal logic.
      -- If you want it, uncomment this, but test without it first:
      -- if in_wezterm then
      --   vim.keymap.set({'n', 't'}, '<C-h>', '<CMD>NavigatorLeft<CR>')
      --   -- ... other keymaps
      -- end
      -- Navigator keymaps using Ctrl (works in both normal and terminal mode)
      vim.keymap.set({"n", "t"}, "<c-h>", "<cmd><C-U>NavigatorLeft<cr>", { desc = "Navigate Left" })
      vim.keymap.set({"n", "t"}, "<c-l>", "<cmd><C-U>NavigatorRight<cr>", { desc = "Navigate Right" })
      vim.keymap.set({"n", "t"}, "<c-k>", "<cmd><C-U>NavigatorUp<cr>", { desc = "Navigate Up" })
      vim.keymap.set({"n", "t"}, "<c-j>", "<cmd><C-U>NavigatorDown<cr>", { desc = "Navigate Down" })
      vim.keymap.set({"n", "t"}, "<c-p>", "<cmd><C-U>NavigatorPrevious<cr>", { desc = "Navigate Previous" })
    end,
  },

  -- ----------------------------------------------------------------------
  -- 2. vim-tmux-navigator (Used ONLY when in tmux and NOT in WezTerm)
  -- ----------------------------------------------------------------------
  {
    "christoomey/vim-tmux-navigator",
    -- Only load if we are specifically in tmux AND not using WezTerm
    cond = in_tmux and not in_wezterm,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      -- Note: TmuxNavigatePrevious is typically <C-\> by convention,
      -- but using <C-p> is also fine if you prefer consistency.
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-p>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
