require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "markdown",
    },
  },
  indent = { enable = true, disable = { 'ruby' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<TAB>",
    },
  },
})
-- Setup treesitter
local ts = require("nvim-treesitter.configs")
ts.setup({
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "llvm",
    "lua",
    "html",
    "javascript",
    "json",
    "make",
    "python",
    "rust",
    "toml",
    "vim",
    "yaml",
  },
  highlight = { enable = true },
})
