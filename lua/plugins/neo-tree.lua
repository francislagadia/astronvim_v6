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
          -- NOTE: neo-tree matches these with Lua patterns (string.find), not glob.
          -- Put path patterns (contain "/") here, filename-only patterns elsewhere.
          "/%.git/",
          "/%.venv/",
          "/__pycache__/",
          "/node_modules/",
          "/build/",
          "/dist/",
          -- macOS user-level system dirs
          "/Applications/",
          "/Library/",
          "/System/",
          "/Volumes/",
          "/private/",
          -- Optional: other noisy home dirs
          "/Movies/",
          "/Music/",
          "/Pictures/",
          "/Public/",
          -- Finder junk
          "%._.*",
        },
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show_by_pattern = {
          "%.pyc$",
          "%.pyo$",
        },
      },
      follow_current_file = { enabled = true }, -- Focus tree on the current file
      scan_mode = "shallow", -- neo-tree has shallow/deep, no scan_depth option
    },
  },
}
