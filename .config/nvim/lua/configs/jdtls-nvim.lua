local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls = require "jdtls"
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.getcwd() -- fallback to current directory

local mason_data = vim.fn.stdpath "data" .. "/mason/packages/jdtls"
local launchers = vim.fn.glob(mason_data .. "/plugins/org.eclipse.equinox.launcher_*.jar", true, true)

if #launchers == 0 then
  vim.notify("jdtls: launcher JAR not found!", vim.log.levels.ERROR)
  return
end

local launcher = launchers[#launchers]

if launcher == "" then
  vim.notify("jdtls: launcher JAR not found!", vim.log.levels.ERROR)
  return
end

-- local workspace_dir = "/opt/homebrew/opt/openjdk@17" .. project_name
local workspace_dir = vim.fn.expand "~/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Helper function for creating keymaps
local function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  vim.keymap.set(
    "v",
    "<space>em",
    [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" }
  )
end

local options = {
  on_attach = on_attach,
  root_dir = root_dir,
  -- cmd = {
  --   --
  --   "java",
  --   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  --   "-Dosgi.bundles.defaultStartLevel=4",
  --   "-Declipse.product=org.eclipse.jdt.ls.core.product",
  --   "-Dlog.protocol=true",
  --   "-Dlog.level=ALL",
  --   "-Xms1g",
  --   "-XX:+IgnoreUnrecognizedVMOptions",
  --   "--add-modules=ALL-SYSTEM",
  --   "--add-opens",
  --   "java.base/java.util=ALL-UNNAMED",
  --   "--add-opens",
  --   "java.base/java.lang=ALL-UNNAMED",
  --   --
  --   "-jar",
  --   launcher,
  --   "-configuration",
  --   "/Users/eashanc/.local/share/nvim/mason/packages/jdtls/config_mac",
  --   "-data",
  --   workspace_dir,
  -- },
  cmd = {
    vim.fn.stdpath "data" .. "/mason/bin/jdtls",
    "-data",
    workspace_dir,
  },
  settings = {
    java = {
      format = {
        settings = {
          -- Use Google Java style guidelines for formatting
          -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
          -- and place it in the ~/.local/share/eclipse directory
          url = "/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
      -- Specify any completion options
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      server = { launchMode = "Hybrid" },
      references = {
        includeDecompiledSources = true,
      },
      implementationsCodeLens = {
        enabled = false,
      },
      referenceCodeLens = {
        enabled = false,
      },
      inlayHints = {
        parameterNames = {
          enabled = "none",
        },
      },
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
    },
  },
}
require("jdtls").start_or_attach(options)
