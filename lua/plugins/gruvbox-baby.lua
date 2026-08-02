return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "gruvbox-baby",
    },
  },
  {
    "luisiacc/gruvbox-baby",
    lazy = false,
    priority = 1000,
    init = function()
      -- gruvbox-baby only exposes medium/dark intensity; dark is the closest match
      -- to the harder gruvbox background variant.
      vim.o.background = "dark"
      vim.g.gruvbox_baby_background_color = "dark"
      vim.g.gruvbox_baby_transparent_mode = 0
    end,
  },
}
