return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- lsp manager
  {
    "williamboman/mason.nvim",
    ensure_installed = {
      "jdtls",
      "prettier",
      "rust-analyzer",
      "typescript-language-server",
      "eslint-lsp",
      "bash-language-server",
    },
  },
  -- Its in the name
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  -- Its in the name
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- Linting
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  -- Allows for visual multiline
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  -- Supports tmux and vim
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  -- Web Dev tagging
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    ft = { "jsx", "js", "ts", "tsx" },
  },
  -- Git workflows
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
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
  -- DAP / debugger
  { "puremourning/vimspector" },
  -- File opener helper
  { "willthbill/opener.nvim" },
  -- Visual highlight / color correction for LSP
  {
    "m-demare/hlargs.nvim",
    lazy = false,
    config = function()
      require("hlargs").setup {
        color = "#7FCFB8",
      }
    end,
  },
  -- Surround functions
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  -- DAP
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
  },
  -- Obsidian file handling
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
      require "configs.obsidian"
    end,
  },
  -- Neovim notification manager
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require "configs.nvim-notify"
    end,
  },
  -- Visual code isolation
  {
    "pocco81/true-zen.nvim",
    lazy = false,
    config = function()
      require "configs.true-zen"
    end,
  },
  -- Visual highlight on current codeblock
  {
    "folke/twilight.nvim",
    lazy = false,
  },
  -- The better tree file viewer
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      opts = require "configs.neo-tree"
    end,
  },
  -- Visual notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.noice"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    after = "nvim-lspconfig",
  },
  -- Git actions within terminal
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    config = function() end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- In-editor terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
  },
  -- LSP Support for jdtls
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  -- Improved finding/jumping
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Visual Cursor animation
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
  -- Visual Scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Top Bar context viewer
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {},
  },
  -- Visual Dashboard ascii-izer
  {
    "MaximilianLloyd/ascii.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
