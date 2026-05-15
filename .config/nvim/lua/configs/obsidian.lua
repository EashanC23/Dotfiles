local options = {
  workspaces = {
    name = "personal",
    path = "~/Documents/Obsidian Vault/"
  },
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2
  },
}

return options
