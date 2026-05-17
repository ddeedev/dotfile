return {
  {
    "neovim/nvim-lspconfig",
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
    opts = function(_, opts)
      local on_publish_diagnostics = vim.lsp.diagnostic.on_publish_diagnostics

      opts.servers.bashls = vim.tbl_deep_extend("force", opts.servers.bashls or {}, {

        handlers = {

          ["textDocument/publishDiagnostics"] = function(err, res, ...)
            local file_name = vim.fn.fnamemodify(vim.uri_to_fname(res.uri), ":t")

            if string.match(file_name, "^%.env") == nil then
              return on_publish_diagnostics(err, res, ...)
            end
          end,
        },
      })

      -- preserve existing options
      opts.inlay_hints = opts.inlay_hints or {}

      -- modify specific settings
      opts.inlay_hints.enabled = false
      -- you can modify other settings here as needed
      -- for example:
      -- opts.autoformat = false
      return opts
    end,
  },
}
