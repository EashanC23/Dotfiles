local options = {
  -- filesystem = {
  --   filtered_items = {
  --     hide_gitignored = false,
  --     hide_dotfiles = false,
  --     hide_ignored = false,
  --     never_show = {
  --       ".DS_store",
  --     },
  --     hide_by_pattern = {
  --       "*.class",
  --     },
  --   },
  -- },
  "container",
  width = "100%",
  right_padding = 1,
  content = {
    {
      "name",
      use_git_status_colors = true,
      zindex = 10,
    },
    { "diagnostics", zindex = 20, align = "right" },
    { "git_status", zindex = 20, align = "right" },
  },
}
return options
