-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local repo_rules = {
  {
    prefix = "/Users/flagadia/github/projects/tiger/integrations/qa-automation/",
    root = "/Users/flagadia/github/projects/tiger/integrations/qa-automation",
  },
  {
    prefix = "/Users/flagadia/github/projects/tiger/integrations/qa-shared-services/",
    root = "/Users/flagadia/github/projects/tiger/integrations/qa-shared-services",
  },
}

local function lazygit_root_for_current_buffer()
  local path = vim.fs.normalize(vim.api.nvim_buf_get_name(0))

  for _, rule in ipairs(repo_rules) do
    if path ~= "" and path:find(rule.prefix, 1, true) == 1 then return rule.root end
  end
end

local function toggle_lazygit()
  local astro = require "astrocore"
  local root = lazygit_root_for_current_buffer()

  if root then
    astro.toggle_term_cmd { cmd = "lazygit -p " .. vim.fn.shellescape(root), direction = "float" }
    return
  end

  local worktree = astro.file_worktree()
  local flags = worktree
      and (" --work-tree=%s --git-dir=%s"):format(
        vim.fn.shellescape(worktree.toplevel),
        vim.fn.shellescape(worktree.gitdir)
      )
    or ""
  astro.toggle_term_cmd { cmd = "lazygit" .. flags, direction = "float" }
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    git_worktrees = {
      {
        toplevel = vim.env.HOME,
        gitdir = vim.env.HOME .. "/.cfg",
      },
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        cmdheight = 1, -- enable command line height of 1 row to see match counts
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        colorcolumn = { 88, 120 }, -- set colorcolumn to psf/black's line width setting
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        python3_host_prog = "~/.pyenv/versions/neovim/bin/python",
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        ["<Leader>gg"] = { toggle_lazygit, desc = "ToggleTerm lazygit" },
        ["<Leader>tl"] = { toggle_lazygit, desc = "ToggleTerm lazygit" },

        ["<Leader>Mr"] = { "<Cmd>RenderMarkdown buf_toggle<CR>", desc = "Toggle render" },

        -- vim-easy-align mappings
        ["ga"] = { ":EasyAlign ", desc = "EasyAlign" },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,

        -- Unset default AstroNvim mappings
        ["<C-s>"] = false, -- disable force write
        ["<C-q>"] = false, -- disable force quit

        -- Unset default AstroNvim leader mappings that will close or write buffers
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<Leader>q"] = false,
        ["<Leader>w"] = false,
        ["<Leader>Q"] = false,
        ["<Leader>W"] = false,
      },
      v = {
        -- vim-easy-align mappings
        ["ga"] = { ":EasyAlign ", desc = "EasyAlign" },
      },
    },
  },
}
