require("conform").setup({
  formatters_by_ft = {
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
  },
  -- Set up format-on-save
  format_on_save = { timeout_ms = 1500, lsp_fallback = true },
})
