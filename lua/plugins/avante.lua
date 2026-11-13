-- Avante: route through the local Cursor CLI agent (`agent acp`) via ACP
-- instead of the community default (copilot), using the already
-- authenticated `~/.local/bin/agent` binary.
-- https://cursor.com/docs/cli/acp

-- ACP's model/mode pickers need a live sidebar+session (avante.acp_config_selector
-- warns "Please open the Avante sidebar first" and bails otherwise), so open the
-- sidebar before invoking them. Mirrors the sidebar-open check already used by the
-- community avante-nvim spec's neo-tree "avante_add_files" integration.
local function ensure_sidebar_open()
  local sidebar = require("avante").get()
  if not sidebar or not sidebar:is_open() then
    require("avante.api").ask()
    sidebar = require("avante").get()
  end
  return sidebar
end

local function select_acp_model()
  ensure_sidebar_open()
  require("avante.api").select_acp_model()
end

local function select_acp_mode()
  ensure_sidebar_open()
  require("avante.api").select_acp_mode()
end

---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    -- AstroCommunity's avante-nvim spec hasn't caught up with avante.nvim's
    -- newer mandatory deps (see avante/init.lua's `avante-requirements` doc
    -- comment), so declare them here. `dependencies` merges across spec
    -- fragments via vim.list_extend, so this adds to (not replaces) the
    -- community spec's dependency list.
    dependencies = {
      "ColinKennedy/mega.cmdparse",
      "ColinKennedy/mega.logging",
    },
    -- defining these as lazy.nvim `keys` makes avante's own safe_keymap_set skip
    -- binding them (it checks for an existing lazy keys handler for the same lhs),
    -- so our sidebar-opening wrapper is what actually runs.
    keys = {
      { "<Leader>AM", select_acp_model, mode = "n", desc = "avante: select ACP model" },
      { "<Leader>Am", select_acp_mode, mode = "n", desc = "avante: select ACP mode" },
    },
    opts = {
      provider = "cursor",
      mode = "agentic",
      mappings = {
        -- avante's own defaults put these under lowercase <leader>a instead
        -- of this config's <Leader>A prefix; alias them for consistency.
        select_acp_model = "<Leader>AM",
        select_acp_mode = "<Leader>Am",
      },
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
