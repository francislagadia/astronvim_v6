-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder
  -- OpenCode: embedded OpenCode chat + keymaps under <Leader>O (and adds an icon)
  { import = "astrocommunity.ai.opencode-nvim" },

  -- Avante: AI sidebar/chat/edit; default keymaps under <Leader>A
  { import = "astrocommunity.completion.avante-nvim" },

  -- Codex.nvim: lightweight AI popup; community spec maps <Leader>Oc by default
  { import = "astrocommunity.completion.codex-nvim" },

  -- Copilot + cmp/blink integration: wires GitHub Copilot suggestions into completion (may affect <Tab>)
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Trouble.nvim: diagnostics/location list UI; adds mappings under <Leader>x...
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- Conform.nvim: formatter runner + :Format command; maps <Leader>lf/<Leader>uf/<Leader>uF and disables LSP formatting
  { import = "astrocommunity.editing-support.conform-nvim" },

  -- CopilotChat.nvim: chat UI; default prefix <Leader>P (configurable via g.copilot_chat_prefix)
  { import = "astrocommunity.editing-support.copilotchat-nvim" },

  -- Undotree: visual undo history; community spec maps <Leader>fu (collides with AstroNvim "find undo")
  { import = "astrocommunity.editing-support.undotree" },

  -- Markdown Preview: opens Markdown in browser via <Leader>mp/<Leader>mt
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },

  -- nvim-spider: smarter word motions; remaps w/e/b/ge in normal/visual/operator-pending modes
  { import = "astrocommunity.motion.nvim-spider" },

  -- JSON tooling: jsonls config + schemastore schemas + treesitter + mason installers
  { import = "astrocommunity.pack.json" },

  -- Lua tooling: lua_ls + stylua (+ optional selene) + treesitter + mason installers
  { import = "astrocommunity.pack.lua" },

  -- Python tooling: ensures python treesitter/debugpy; adds venv selector, dap-python, neotest adapter
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.ruff" },

  -- TOML tooling: taplo + treesitter + mason installers
  { import = "astrocommunity.pack.toml" },

  -- YAML tooling: yamlls + schemastore schemas + treesitter + mason installers
  { import = "astrocommunity.pack.yaml" },

  -- rest.nvim: run HTTP requests from .http buffers; adds <Leader>r... mappings
  { import = "astrocommunity.programming-language-support.rest-nvim" },

  -- nvim-snippets: snippet collection + friendly-snippets integration (and disables LuaSnip in this pack)
  { import = "astrocommunity.snippet.nvim-snippets" },

  -- vim-easy-align: adds :EasyAlign; you typically use `ga` to start an alignment
  { import = "astrocommunity.syntax.vim-easy-align" },

  -- neotest: test runner UI/integration
  { import = "astrocommunity.test.neotest" },
}
