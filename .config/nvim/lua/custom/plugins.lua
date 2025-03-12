local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

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
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = require "custom.keys.trouble",
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
    ft = "rust",
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  { "puremourning/vimspector" },
  { "willthbill/opener.nvim" },
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
      require("nvim-surround").setup {}
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
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
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require "custom.configs.nvim-notify"
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
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    dev = false,
    config = function()
      require "custom.configs.neo-tree"
    end,
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
    lazy = false,
    config = function() end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
  },
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      require "custom.configs.jdtls-nvim"
    end,
    ft = "java",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = require "custom.keys.flash",
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      cursor_color = "#c4ebf2",
      stiffness = 0.7,
      trailing_stiffness = 0.2,
      distance_stop_animating = 0.1,
    },
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    event = "VeryLazy",
    opts = {},
  },
}

return plugins
