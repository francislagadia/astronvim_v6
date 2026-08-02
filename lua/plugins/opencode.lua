local opencode_cmd = "opencode --port"

local terminal_opts = {
  win = {
    position = "right",
    enter = false,
  },
}

local function toggle_embedded_opencode()
  require("snacks.terminal").toggle(opencode_cmd, terminal_opts)
end

---@type LazySpec
return {
  {
    "NickvanDyke/opencode.nvim",
    init = function()
      -- AstroCommunity still maps <Leader>Ot to require("opencode").toggle(),
      -- but current opencode.nvim removed that API, so we provide terminal-based startup.
      vim.g.opencode_opts = vim.tbl_deep_extend("force", vim.g.opencode_opts or {}, {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, terminal_opts)
          end,
        },
      })
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      maps.n["<Leader>Ot"] = {
        toggle_embedded_opencode,
        desc = "Toggle embedded",
      }
    end,
  },
}
