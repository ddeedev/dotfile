return {
  -- import theme repo here
  --{ "ellisonleao/gruvbox.nvim" },
  { "Mofiqul/dracula.nvim" },
  -- { "talha-akram/noctis.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
