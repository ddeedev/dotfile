return {
  "akinsho/toggleterm.nvim",
  enabled = false,
  config = function()
    require("toggleterm").setup({
      --    open_mapping = "<leader>fd",
      shade_terminals = false,
      -- add --login so ~/.zprofile is loaded
      -- https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile/16021#16021
      shell = "zsh --login",
    })
  end,
  keys = {
    { mode = { "n" }, "<leader>tt","<Cmd>ToggleTerm<Cr>" ,desc = "Toggle Primary Terminal" },
    { mode = { "n" }, "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
    {
      mode = { "n" },
      "<leader>td",
      "<cmd>ToggleTerm size=40 direction=horizontal<cr>",
      desc = "Open a large horizontal terminal",
    },
  },
}
