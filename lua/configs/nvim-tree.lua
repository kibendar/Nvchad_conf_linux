local present, nvim_tree = pcall(require, "nvim-tree")
if not present then
  return
end

nvim_tree.setup {
  renderer = {
    icons = {
      git_placement = "before", -- or "after"
      show = {
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "◈",
          staged = "◆",
          unmerged = "⊘",
          renamed = "⇄",
          untracked = "⊕",
          deleted = "⊖",
          ignored = "⌀",
        },
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
}
