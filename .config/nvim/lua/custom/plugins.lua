local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
    ensure_installed = {
      "jdtls",
      "prettier",
      "rust-analyzer",
      "typescript-language-server",
      "eslint-lsp",
      "bash-language-server",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    ft = { "jsx", "js", "ts", "tsx" },
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup {
        color = "#7FCFB8",
      }
    end,
  },
  -- rust tools
  {

    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "puremourning/vimspector",
  },
  {
    "willthbill/opener.nvim",
  },
  {
    "m-demare/hlargs.nvim",
    lazy = false,
    config = function()
      require("hlargs").setup {
        color = "#7FCFB8",
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {},
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    event = {
      "BufReadPre path/to/my-vault/**.md",
      "BufNewFile path/to/my-vault/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require "custom.configs.obsidian"
    end,
  },
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    config = function()
      require "custom.configs.pomo"
    end,
    dependencies = {
      "rcarriga/nvim-notify",
    },
  },
  {
    "pocco81/true-zen.nvim",
    lazy = false,
    config = function()
      require "custom.configs.true-zen"
    end,
  },
  {
    {
      "folke/twilight.nvim",
      lazy = false,
      opts = {},
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "custom.configs.noice"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    after = "nvim-lspconfig",
  },
  {
    "kdheepak/lazygit.nvim",
    lazy=false,
    config = function()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}

return plugins
