-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "gruvbox",
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    init = function() -- init function runs before the plugin is loaded
      vim.o.background = "dark" -- dark or light
    end,
    opts = function(_, opts)
      -- override default options thru the opts table
      opts.terminal_colors = true
      opts.contrast = "hard"
      opts.transparent_mode = true
      opts.italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = true,
      }
    end,
  },
}
