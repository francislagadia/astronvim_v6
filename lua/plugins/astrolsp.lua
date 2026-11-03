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

local function resolve_project_ruff(root_dir)
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
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    config = {
      ruff = {
        -- Prefer the project's own Ruff binary over Mason/global installs.
        cmd = function(dispatchers, config)
          local cmd = resolve_project_ruff((config or {}).root_dir)
          return vim.lsp.rpc.start({ cmd, "server" }, dispatchers)
        end,
      },
      basedpyright = {
        -- Point basedpyright at the project's pyenv virtualenv (via .python-version), falling
        -- back to the astrocommunity pack's default (PATH-resolved python) otherwise. Must be
        -- before_init, not on_new_config - the pack's own before_init runs later and would
        -- otherwise overwrite pythonPath unconditionally.
        before_init = function(_, config)
          local python_path = resolve_pyenv_tool(config.root_dir, "python") or vim.fn.exepath "python"
          if not config.settings then config.settings = {} end
          if not config.settings.python then config.settings.python = {} end
          config.settings.python.pythonPath = python_path
        end,
      },
    },
  },
}
