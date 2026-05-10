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

    ["<leader>ra"] = { ":lua vim.lsp.buf.rename()<CR>", "rename" },

    --increment/decrement
    ["+"] = { "<C-a>", "increment" },
    ["-"] = { "<C-x>", "decrement" },
    ["<leader>ti"] = {
      function()
        local line = vim.api.nvim_get_current_line()
        local new_line = line:gsub("(%d%d?):(%d%d)", function(h, m)
          local h_num, m_num = tonumber(h), tonumber(m)

          m_num = m_num + 1

          if m_num == 60 then
            m_num = 0
            h_num = (h_num + 1) % 24
          end

          return string.format("%02d:%02d", h_num, m_num)
        end)
        vim.api.nvim_set_current_line(new_line)
      end,
      "Increment timestamp by 1 min",
    },
    ["<leader>td"] = {
      function()
        local line = vim.api.nvim_get_current_line()
        local new_line = line:gsub("(%d%d?):(%d%d)", function(h, m)
          local h_num, m_num = tonumber(h), tonumber(m)

          m_num = m_num - 1

          if m_num < 0 then
            m_num = 59
            h_num = (h_num - 1) % 24
          end

          return string.format("%02d:%02d", h_num, m_num)
        end)
        vim.api.nvim_set_current_line(new_line)
      end,
      "Decrement timestamp by 1 min",
    },

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

    --lazy git
    ["<leader>lg"] = { ":LazyGit<CR>", "open LazyGit " },
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
