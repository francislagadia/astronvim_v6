-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      opts = opts or {}
      opts.flavour = "mocha"
      opts.background = { dark = "mocha" }
      opts.transparent_background = false
      opts.term_colors = true
      return opts
    end,
  },
}
