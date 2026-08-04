local ruff_root_files = { "pyproject.toml", "ruff.toml", ".ruff.toml" }

local function executable(path)
  return path and vim.fn.executable(path) == 1 and path or nil
end

local function resolve_pyenv_tool(root_dir, tool)
  local python_version_file = vim.fs.find(".python-version", { path = root_dir, upward = true })[1]
  if not python_version_file then return nil end

  local env_name = vim.trim(table.concat(vim.fn.readfile(python_version_file), "\n"))
  if env_name == "" then return nil end

  return executable(vim.fs.joinpath(vim.env.HOME, ".pyenv", "versions", env_name, "bin", tool))
end

local function resolve_project_ruff(dirname)
  local root_dir = vim.fs.root(dirname, ruff_root_files)
  if root_dir then
    local local_ruff = executable(vim.fs.joinpath(root_dir, ".venv", "bin", "ruff"))
      or executable(vim.fs.joinpath(root_dir, "venv", "bin", "ruff"))
    if local_ruff then return local_ruff end

    local pyenv_ruff = resolve_pyenv_tool(root_dir, "ruff")
    if pyenv_ruff then return pyenv_ruff end
  end

  return vim.fn.exepath "ruff"
end

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
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        ruff_fix = {
          command = function(_, ctx) return resolve_project_ruff(ctx.dirname) end,
        },
        ruff_organize_imports = {
          command = function(_, ctx) return resolve_project_ruff(ctx.dirname) end,
        },
        ruff_format = {
          command = function(_, ctx) return resolve_project_ruff(ctx.dirname) end,
        },
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
