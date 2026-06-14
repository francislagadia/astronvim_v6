# AGENTS.md

## Purpose

This repo is an AstroNvim v6 user configuration.

Run it in an isolated appname:

`NVIM_APPNAME=astronvim_v6 nvim`

Do not modify the v5 config at `~/.config/nvim` from work in this repo.

## Entry Points

- `init.lua`: bootstraps `lazy.nvim` then loads `lua/lazy_setup.lua`
- `lua/lazy_setup.lua`: root Lazy spec
  - imports `community` first
  - imports `plugins` second

## Where To Make Changes

- `lua/community.lua`: enable/disable AstroCommunity modules (feature selection)
- `lua/plugins/*.lua`: local plugin specs/overrides
  - `lua/plugins/astrocore.lua`: options + keymaps
  - `lua/plugins/git_branch_sessions.lua`: git-branch-specific Resession recipe
- `lazy-lock.json`: plugin pin file (changes when plugins are installed/updated)

## Guardrails (Intentional Behavior)

- Keep existing v5-style disabled keymaps in `lua/plugins/astrocore.lua`.
  - Includes keeping `<Leader>c` disabled.
- Pruned/unused plugins should simply not be included.
  - Do not add explicit `{ enabled = false }` specs unless requested.
- Only commit `lazy-lock.json` when plugin pins changed intentionally.

## Testing

- Fast config load check:
  - `NVIM_APPNAME=astronvim_v6 nvim --headless "+qall"`
- After changing plugin specs:
  - Run `:Lazy sync` in the isolated instance.

## Commits

- Use the `caveman-commit` skill for commit messages.
- Keep commits small and logically grouped.
