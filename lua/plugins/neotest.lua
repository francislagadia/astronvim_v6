-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize NeoTree
---@type LazySpec
return {
  {
    "nvim-neotest/neotest-python",
    dependencies = { "nvim-neotest/neotest" },
    opts = {
      -- Optional: pass options here
      runner = "pytest",
    },
  },
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(
        opts.adapters,
        require "neotest-python" {
          -- any extra config
          runner = "pytest",
        }
      )
    end,
  },
}
