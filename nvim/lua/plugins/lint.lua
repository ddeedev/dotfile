return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = {
            "--disable", "MD012",
            "--disable", "MD013",
            "--disable", "MD031",
            "--disable", "MD049",
            "--"
          },
        },
      },
    },
  },
}
