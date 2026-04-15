local M = require("plugins.configs.lspconfig")
local capabilities = M.capabilities
local util = require "lspconfig/util"

-- Move on_attach logic to LspAttach autocmd (new way)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(args)
    -- Call NVChad's on_attach if it exists
    if M.on_attach then
      M.on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
    end
  end
})

-- Configure servers with default settings
local servers = { "html", "cssls", "ts_ls", "clangd", "bashls", "marksman" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    capabilities = capabilities,
  })
end

-- Configure pylsp with custom settings
vim.lsp.config('pylsp', {
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391" },
          maxLineLength = 100,
        },
      },
    },
  },
})

-- Configure tailwindcss with extensive custom settings
vim.lsp.config('tailwindcss', {
  capabilities = capabilities,
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "django-html",
    "ejs",
    "gohtml",
    "html",
    "html-eex",
    "css",
    "postcss",
    "sass",
    "scss",
    "javascript",
    "javascriptreact",
    "rescript",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
    },
  },
  on_new_config = function(new_config)
    if not new_config.settings then
      new_config.settings = {}
    end
    if not new_config.settings.editor then
      new_config.settings.editor = {}
    end
    if not new_config.settings.editor.tabSize then
      -- set tab size for hover
      new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  root_markers = function(fname)
    return util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
      or util.root_pattern("postcss.config.js", "postcss.config.ts")(fname)
      or util.find_package_json_ancestor(fname)
      or util.find_node_modules_ancestor(fname)
      or util.find_git_ancestor(fname)
  end,
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
})

-- Enable all configured servers
vim.lsp.enable(vim.tbl_extend("force", servers, { "pylsp", "tailwindcss" }))

