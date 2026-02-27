return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",  -- Inline dep
  },
  opts = {
    rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
    autotag = {
      enable = true,
      filetypes = { "html", "javascript", "typescript", "markdown" },
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        scope_incremental = "<TAB>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
      },
    },
    highlight = { enable = true },
    auto_install = true,
    ensure_installed = {
      "rust", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "yaml",
    },
    -- ← ADD THESE: Your textobjects keys live here
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- Functions & methods
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["am"] = "@method.outer",
          ["im"] = "@method.inner",
          -- Structs & impls (Rust!)
          ["as"] = "@struct.outer",
          ["is"] = "@struct.inner",
          ["ai"] = "@impl.outer",
          ["ii"] = "@impl.inner",
          -- Fields & params
          ["aF"] = "@field.outer",
          ["iF"] = "@field.inner",
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
          -- Control flow
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["a?"] = "@conditional.outer",
          ["i?"] = "@conditional.inner",
          -- Statements & blocks
          ["aS"] = "@statement.outer",
          ["iS"] = "@statement.inner",
          -- Comments & doc
          ["ac"] = "@comment.outer",
          ["ic"] = "@comment.inner",
        },
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@struct.outer"] = "V",
          ["@statement.outer"] = "V",
        },
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]m"] = "@method.outer",
          ["]s"] = "@struct.outer",
          ["]i"] = "@impl.outer",
          ["]p"] = "@parameter.inner",
          ["]l"] = "@loop.outer",
          ["]?"] = "@conditional.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]M"] = "@method.outer",
          ["]S"] = "@struct.outer",
          ["]I"] = "@impl.outer",
          ["]P"] = "@parameter.inner",
          ["]L"] = "@loop.outer",
          ["]?"] = "@conditional.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[m"] = "@method.outer",
          ["[s"] = "@struct.outer",
          ["[i"] = "@impl.outer",
          ["[p"] = "@parameter.inner",
          ["[l"] = "@loop.outer",
          ["[?"] = "@conditional.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[M"] = "@method.outer",
          ["[S"] = "@struct.outer",
          ["[I"] = "@impl.outer",
          ["[P"] = "@parameter.inner",
          ["[L"] = "@loop.outer",
          ["[?"] = "@conditional.outer",
        },
      },
    },
  },
}

