if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
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
    init = function() -- init function runs before the plugin is loaded
      vim.g.gruvbox_baby_transparent_mode = 1
      vim.g.background_color = "dark"
    end,
  },
}
