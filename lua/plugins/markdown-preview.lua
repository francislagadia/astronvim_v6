return {
  {
    "iamcco/markdown-preview.nvim",
    -- Use the plugin's documented Node install path; the Vim helper left the app missing
    -- runtime deps locally, which breaks :MarkdownPreview at startup.
    build = "cd app && npx --yes yarn install",
  },
}
