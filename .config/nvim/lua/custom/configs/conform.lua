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
    java = { "ast-grep" },
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
    return { "--style=google", "-f", "-t", "-p", "-C" }
  end,
}

require("conform").setup {
  formatters_by_ft = {
    java = { "ast-grep" },
  },
  format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
  formatters = {
    ["ast-grep"] = {
      command = "ast-grep",
      args = { "scan", "-U", "$FILENAME" },
      stdin = false, -- important: scan updates files, not stdout
      -- cwd = function(self, ctx)
      --   return require("conform.util").root_file { "sgconfig.yml", ".git" }(ctx)
      -- end,
      require_cwd = true, -- don’t run if there’s no project config
    },
  },
}

require("conform").setup(options)
