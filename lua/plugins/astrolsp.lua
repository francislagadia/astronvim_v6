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
        -- Point basedpyright at the project's pyenv virtualenv (via .python-version),
        -- same convention already used for ruff above.
        on_new_config = function(config, root_dir)
          local python_path = resolve_pyenv_tool(root_dir, "python")
          if python_path then
            config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
              python = { pythonPath = python_path },
            })
          end
        end,
      },
    },
  },
}
