local options = {
  notifiers = {
    {
      name = "Default",
      opts = {
        sticky = true,
        title_icon = "󱎫",
        text_icon = "󰄉",
      },
    },

    { name = "System" },
  },
}

require("pomo").setup(options)
