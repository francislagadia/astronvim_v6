---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        json = { "jq" },
        html = { "prettierd" },
        yaml = { "prettierd" },
      })

      local default_format_on_save = opts.format_on_save
      opts.format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == "yaml" then return nil end
        return type(default_format_on_save) == "function" and default_format_on_save(bufnr)
          or default_format_on_save
          or { lsp_format = "fallback" }
      end

      return opts
    end,
  },
}
