return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
        layout = "vertical",
        width = 0.42,
      })
      return opts
    end,
    keys = {
      {
        "<leader>cc",
        function()
          -- 1) Visually select the entire buffer (so #selection has content)
          vim.cmd "normal! ggVG"

          -- 2) Open CopilotChat with a sticky selection tag
          require("CopilotChat").open { prompt = "> #selection\n" }

          -- 3) Exit visual mode (so you're not stuck in VISUAL)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        end,
        desc = "CopilotChat: open side-by-side with WHOLE BUFFER as #selection (sticky)",
      },
    },
  },
}
