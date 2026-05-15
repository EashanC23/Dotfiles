-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {

  nvdash = {
    load_on_startup = true,

    header = " ",

    buttons = {
      { "󰈚  Recent Files", "Space F O", "Telescope oldfiles" },
      { "󰍉  Find File", "Space F L", "Telescope find_files" },
      { "  Bookmarks", "Space M A", "Telescope marks" },
      { "  Mappings", "Space C H", "NvCheatsheet" },
    },

    tabufline = {
      enabled = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
      bufwidth = 21,
    },
  },
}

return M
