-- Explicitly disable plugins we pruned from the v5 config.
-- This prevents accidental re-introduction via community packs.

---@type LazySpec
return {
  { "stevearc/conform.nvim", enabled = false },
  { "rest-nvim/rest.nvim", enabled = false },
  { "chrisgrieser/nvim-spider", enabled = false },
  { "CopilotC-Nvim/CopilotChat.nvim", enabled = false },
}
