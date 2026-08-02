-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize NeoTree
---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 60, -- Width of the NeoTree window
    },
    filesystem = {
      filtered_items = {
        always_show = {
          ".gitignore",
          ".pylintrc",
          ".secrets.toml",
          "pyproject.toml",
          "pyrightconfig.json",
        },
        hide_by_name = {
          ".DS_Store",
          ".hypothesis",
          ".idea",
          ".pytest_cache",
          ".ruff_cache",
          ".tox",
          "thumbs.db",
        },
        hide_by_pattern = {
          "**/.git/**",
          "**/.venv/**",
          "**/__pycache__/**",
          "**/build/**",
          "**/dist/**",
          "**/node_modules/**",
          -- macOS user-level system dirs
          "**/Applications/**",
          "**/Library/**",
          "**/System/**",
          "**/Volumes/**",
          "**/private/**",
          -- Optional: other noisy home dirs
          "**/Movies/**",
          "**/Music/**",
          "**/Pictures/**",
          "**/Public/**",
          -- Finder junk
          "**/.DS_Store",
          "**/._*",
        },
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show_by_pattern = {
          "**/*.py[a-zA-Z]",
        },
      },
      follow_current_file = true, -- Automatically focus the NeoTree window on the current file
      scan_depth = 3, -- Limit the depth of directory scanning to 3 levels
    },
  },
}
