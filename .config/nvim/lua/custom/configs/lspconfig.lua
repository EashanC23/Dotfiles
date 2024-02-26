local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require "lspconfig/util"

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "bashls", "marksman" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.bash_language_server.setup{
  -- filetypes = {"sh","zsh"},
-- }

lspconfig.pylsp.setup {
  filetypes = {"python"},
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}


lspconfig.tailwindcss.setup {
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
  root_dir = function(fname)
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
}
--
-- lspconfig.pyright.setup { blabla}
