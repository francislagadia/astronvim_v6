-- Avante: route through the local Cursor CLI agent (`agent acp`) via ACP
-- instead of the community default (copilot), using the already
-- authenticated `~/.local/bin/agent` binary.
-- https://cursor.com/docs/cli/acp

---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "cursor",
      mode = "agentic",
      acp_providers = {
        cursor = {
          command = vim.fn.expand "~/.local/bin/agent",
          args = { "acp" },
          auth_method = "cursor_login",
          env = {
            HOME = os.getenv "HOME",
            PATH = os.getenv "PATH",
            CURSOR_API_KEY = os.getenv "CURSOR_API_KEY",
          },
        },
      },
    },
  },
}
