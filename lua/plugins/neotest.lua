-- AstroCommunity's python pack already wires neotest + neotest-python.
-- Configure here without re-inserting adapters to avoid duplicates.
---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.output = vim.tbl_deep_extend("force", opts.output or {}, { open_on_run = true })
      opts.log_level = vim.log.levels.DEBUG
      return opts
    end,
  },
  {
    "nvim-neotest/neotest-python",
    opts = function(_, opts)
      opts = opts or {}
      opts.runner = "pytest"
      -- Follow pytest.ini: python_files = Test*.py test_*.py *_test.py
      opts.is_test_file = function(file_path)
        if not file_path:match "%.py$" then return false end
        local name = file_path:match "[^/\\]+$" or file_path
        return name:match "^Test.*%.py$" ~= nil or name:match "^test_.*%.py$" ~= nil or name:match "_test%.py$" ~= nil
      end

      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = opts or {}
      local ensure = opts.ensure_installed
      if type(ensure) == "table" then
        if not vim.tbl_contains(ensure, "python") then table.insert(ensure, "python") end
      elseif ensure ~= "all" then
        opts.ensure_installed = { "python" }
      end
      return opts
    end,
  },
}
