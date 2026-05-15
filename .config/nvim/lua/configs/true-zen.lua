local options = {
  modes = { -- configurations per mode
    ataraxis = {
      shade = "light", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
      backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
      minimum_writing_area = { -- minimum size of main window
        width = 70,
        height = 44,
      },
      quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
      padding = { -- padding windows
        left = 52,
        right = 52,
        top = 0,
        bottom = 0,
      },
      callbacks = { -- run functions when opening/closing Ataraxis mode
        open_pre = nil,
        open_pos = nil,
        close_pre = nil,
        close_pos = nil,
      },
    },
    minimalist = {
      ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
      options = { -- options to be disabled when entering Minimalist mode
        number = false,
        relativenumber = false,
        showtabline = 0,
        signcolumn = "no",
        statusline = "",
        cmdheight = 1,
        laststatus = 0,
        showcmd = false,
        showmode = false,
        ruler = false,
        numberwidth = 1,
      },
      callbacks = { -- run functions when opening/closing Minimalist mode
        open_pre = nil,
        open_pos = nil,
        close_pre = nil,
        close_pos = nil,
      },
    },
    narrow = {
      folds_style = "informative",
      run_ataraxis = true, -- display narrowed text in a Ataraxis session
      callbacks = { -- run functions when opening/closing Narrow mode
        open_pre = nil,
        open_pos = nil,
        close_pre = nil,
        close_pos = nil,
      },
    },
    focus = {
      callbacks = { -- run functions when opening/closing Focus mode
        open_pre = nil,
        open_pos = nil,
        close_pre = nil,
        close_pos = nil,
      },
    },
  },
  integrations = {
    tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
    twilight = true, -- enable twilight (ataraxis)
    lualine = false, -- hide nvim-lualine (ataraxis)
  },
}
require("conform").setup(options)
