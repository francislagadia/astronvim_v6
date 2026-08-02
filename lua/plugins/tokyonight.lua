-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    init = function() -- init function runs before the plugin is loaded
      vim.o.background = "dark" -- dark or light
    end,
    opts = function(_, opts)
      opts = opts or {}
      opts.style = "night"
      opts.transparent = true
      opts.terminal_colors = true
      opts.styles = vim.tbl_deep_extend("force", opts.styles or {}, {
        comments = { italic = true },
        keywords = { italic = false },
      })
      return opts
    end,
  },
}
