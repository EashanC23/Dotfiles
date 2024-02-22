--@type MappingsTable
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

    --increment/decrement
    ["+"] = { "<C-a>", "increment" },
    ["-"] = { "<C-x>", "decrement" },

    --splitting windows
    ["<leader>sh"] = { ":split<Return>", "horizontal split" },
    ["<leader>sv"] = { ":vsplit<Return>", "vertical split" },

    --Start and end of lines
    ["H"] = { "^", "start of line" },
    ["L"] = { "$", "end of line" },

    -- Trouble.nvim
    ["<leader>tt"] = { ":TroubleToggle<Return>", "Toggle Trouble.nvim" },

    -- True zen
    ["<leader>tzm"] = { ":TZMinimalist <Return>", "Toggle True-zen Minimalist" },
    ["<leader>tza"] = { ":TZAtaraxis <Return>", "Toggle True-zen Ataraxis" },
    ["<leader>tzn"] = { ":TZNarrow <Return>", "Toggle True-zen Narrow" },

    -- Twilight reading
    ["<leader>tw"] = { ":Twilight <Return>", "Toggle True-zen" },

    -- Clearing notifications
    ["<leader>nd"] = { ":NoiceDismiss<CR>", "dismiss all noice messages" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    -- shifting multiple lines
    ["J"] = { ":m '>+1<CR>gv=gv" },
    ["K"] = { ":m '<-2<CR>gv=gv" },
  },
}

-- more keybinds!

return M
