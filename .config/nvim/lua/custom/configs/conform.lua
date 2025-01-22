local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier", "rustywind" },
    typescript = { "prettier", "rustywind" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "ruff" },

    sh = { "shfmt" },
    java = {"astyle"},
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  format_on_save = {
    lsp_fallback = "fallback",
  },
  format_after_save = {
    lsp_fallback = true,
  },
}
require("conform").formatters.astyle = {
  prepend_args = function(self, ctx)
    return { "--style=google", "-f", "-t", "-p", "-C"}
  end,
}

require("conform").setup(options)
