require "nvchad.mappings"

local map = vim.keymap.set


-- default
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- QOL
map("n", "<leader>fm",
      function()
        require("conform").format()
      end, { desc = "Format current file w conform"})

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>sh", ":split<CR>", { desc = "horizontal split pane" })
map("n", "<leader>sv", ":vsplit<CR>", { desc = "vertical split pane" })

map("n", "<leader>nd", ":NoiceDismiss<CR>", { desc = "dismiss all noice messages" })


-- Obsidian
map("n", "<leader>ti",
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
      { desc = "Increment timestamp by 1 min" })

map("n", "<leader>td",
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
      { desc = "Decrement timestamp by 1 min" }
    )


--neo tree
map("n", "<leader>pv", "<cmd> Neotree toggle<cr>", { desc = "Toggle neo tree open/close" })


-- trouble 
map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

