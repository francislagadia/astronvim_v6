-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "nvim-neotest/neotest-python",
    dependencies = { "nvim-neotest/neotest" },
    opts = {
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
          runner = "pytest",
        }
      )
    end,
  },
}
