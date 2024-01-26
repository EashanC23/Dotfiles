---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    -- remaps for convenience
    ["<leader>pv"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<leader>ff"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<leader>fl"] = { "<cmd> Telescope find_files <CR>", "Find files" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    ["J"] = { ":m '>+1<CR>gv=gv"},
    ["K"] = { ":m '<-2<CR>gv=gv"},
  },
}

-- more keybinds!

return M
