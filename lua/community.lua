-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- OpenCode: embedded OpenCode chat + keymaps under <Leader>O (and adds an icon)
  { import = "astrocommunity.ai.opencode-nvim" },

  -- Avante: AI sidebar/chat/edit; default keymaps under <Leader>A
  { import = "astrocommunity.ai.avante-nvim" },

  -- Codex.nvim: lightweight AI popup; community spec maps <Leader>Oc by default
  { import = "astrocommunity.ai.codex-nvim" },

  -- Catppuccin: keep available as an optional theme
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Gruvbox Baby: active theme, imported from AstroCommunity
  { import = "astrocommunity.colorscheme.gruvbox-baby" },

  -- Gruvbox: keep available as an optional theme
  { import = "astrocommunity.colorscheme.gruvbox-nvim" },

  -- TokyoNight: keep available as an optional theme, but do not switch to it by default
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },

  -- Copilot + cmp/blink integration
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Trouble.nvim: diagnostics/location list UI
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- Conform.nvim: formatter runner + :Format command
  { import = "astrocommunity.editing-support.conform-nvim" },

  -- Undotree: visual undo history
  { import = "astrocommunity.editing-support.undotree" },

  -- Markdown Preview
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },

  -- JSON tooling
  { import = "astrocommunity.pack.json" },

  -- Lua tooling
  { import = "astrocommunity.pack.lua" },

  -- Python tooling
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.python.basedpyright" },

  -- TOML tooling
  { import = "astrocommunity.pack.toml" },

  -- YAML tooling
  { import = "astrocommunity.pack.yaml" },

  -- nvim-snippets
  { import = "astrocommunity.snippet.nvim-snippets" },

  -- vim-easy-align
  { import = "astrocommunity.syntax.vim-easy-align" },

  -- neotest
  { import = "astrocommunity.test.neotest" },
}
