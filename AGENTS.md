# AGENTS.md

## Purpose

This repo is the current AstroNvim v6 user configuration.

It was ported from the prior v5 config at <https://github.com/francislagadia/astronvim_v5>.
Preserve intentional v5-era behavior unless there is a clear reason to modernize it during v6 work.

## Documentation

- AstroNvim docs: <https://docs.astronvim.com/>
- AstroNvim plugin customization: <https://docs.astronvim.com/configuration/customizing_plugins/>
- AstroCommunity imports: <https://github.com/AstroNvim/astrocommunity>
- Lazy.nvim plugin spec: <https://lazy.folke.io/spec>
- opencode.nvim README: <https://github.com/nickjvandyke/opencode.nvim>
- opencode.nvim config defaults: <https://github.com/nickjvandyke/opencode.nvim/blob/main/lua/opencode/config.lua>
- snacks.nvim terminal docs: <https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md>

## Migration Notes

- Treat this repo as a v5 behavior port running on AstroNvim v6, not as a fresh default v6 setup.
- Prefer preserving established user-facing behavior during cleanup:
  - keymaps
  - plugin choices
  - workflow-oriented UI decisions
- When modernizing something for v6 compatibility, keep the change as small as possible and document the reason in code comments or the commit message.
- Prefer moving old catch-all config into the v6 structure instead of reviving legacy patterns:
  - community imports belong in `lua/community.lua`
  - plugin overrides belong in `lua/plugins/*.lua`
  - `lua/polish.lua` should stay off unless there is a specific reason to use it
- If a v5 behavior conflicts with current upstream defaults, prefer a local override over changing the workflow to match upstream.

## Entry Points

- `init.lua`: bootstraps `lazy.nvim` then loads `lua/lazy_setup.lua`
- `lua/lazy_setup.lua`: root Lazy spec
  - imports `community` first
  - imports `plugins` second
- `lua/polish.lua`: last hook loaded by `init.lua`; currently disabled with an early return

## Where To Make Changes

- `lua/community.lua`: enable/disable AstroCommunity modules (feature selection)
- `lua/plugins/*.lua`: local plugin specs/overrides
  - `lua/plugins/astrocore.lua`: options + keymaps
  - `lua/plugins/git_branch_sessions.lua`: git-branch-specific Resession recipe
  - `lua/plugins/mason.lua`: Mason ensured tools
  - `lua/plugins/neotest.lua`: neotest behavior and pytest filename matching
  - `lua/plugins/opencode.lua`: embedded OpenCode terminal startup and `<Leader>Ot`
- `lua/polish.lua`: catch-all Lua hook; leave disabled unless you intentionally want config there
- `lazy-lock.json`: plugin pin file (changes when plugins are installed/updated)

## Guardrails (Intentional Behavior)

- Keep existing v5-style disabled keymaps in `lua/plugins/astrocore.lua`.
  - Includes keeping `<Leader>c` disabled.
- Pruned/unused plugins should simply not be included.
  - Do not add explicit `{ enabled = false }` specs unless requested.
- Only commit `lazy-lock.json` when plugin pins changed intentionally.
- `lua/polish.lua` is intentionally inactive; prefer normal plugin/community config locations first.

## OpenCode Notes

- `lua/plugins/opencode.lua` keeps embedded OpenCode working with a local terminal-based startup path.
- `<Leader>Ot` is maintained locally and should not rely on `require("opencode").toggle()`.
- If plugin updates break OpenCode again, check both the AstroCommunity mapping and the local workaround in `lua/plugins/opencode.lua`.

## After Updating (Lazy/Mason)

- If you run `<Leader>pa` / update plugins:
  - Verify OpenCode still works: try `<Leader>Ot`.
  - Run a fast config load check: `nvim --headless "+qall"`
  - If OpenCode fails, inspect `lua/plugins/opencode.lua` rather than assuming the upstream `toggle()` API still exists.

## Security / Repo Hygiene

- Do not commit `.env` files, private keys, tokens, or machine-local credentials.
- If you need to check for leaks, scan git history, not just the working tree.
- Useful history checks:
  - `git log --all -p --no-ext-diff`
  - `git rev-list --all | xargs git grep -n -I -E "<pattern>"`
- A heuristic history scan of this repo did not find obvious committed secrets, but unusual formats can still evade simple pattern checks.

## Testing

- Fast config load check:
  - `nvim --headless "+qall"`
- After changing plugin specs:
  - Run `:Lazy sync` in this config.

## Commits

- Use the `caveman-commit` skill for commit messages.
- Keep commits small and logically grouped.
