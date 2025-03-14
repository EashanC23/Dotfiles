---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

local headers = require "custom.headers_lewd"

local function selectRandomHeader()
  math.randomseed(os.time()) -- Seed the random number generator
  local index = math.random(#headers) -- Select a random index
  return headers[index] -- Return the selected header
end

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,

    header = selectRandomHeader(),

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

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
