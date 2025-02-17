local km = vim.keymap

-- Here is a utility function that closes any floating windows when you press escape
local function close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

km.set("n", "<Leader>u", ":Lazy update<CR>",    { desc = "Lazy Update (Sync)" })
km.set("n", "<Leader>n", "<cmd>enew<CR>",       { desc = "New File" })
km.set("n", "<Leader>a", "ggVG<c-$>",           { desc = "Select All" })
km.set("v", "y", "ygv<Esc>",                    { desc = "Yank and reposition cursor" })
km.set("n", "<Delete>", "<cmd>:w<CR>",          { desc = "Save file" })
km.set("n", "<leader>l", ":LazyGit<cr>",        { desc = "Lazygit", silent = true })

km.set({ "n", "x" }, "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste Above" })
km.set({ "n", "x" }, "]p", '<Cmd>exe "put "  . v:register<CR>', { desc = "Paste Below" })

km.set("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

km.set("n", "<Leader>u", ":Lazy update<CR>", { desc = "Lazy Update (Sync)" })
km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })
km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

-- Make visual yanks place the cursor back where started
km.set("v", "y", "ygv<Esc>", { desc = "Yank and reposition cursor" })
-- km.set("n", "<Delete>", "<cmd>:w<CR>", { desc = "Save file" })

-- FZF navigation
km.set("n", "<leader>p", require("fzf-lua").files, { desc = "FZF Files" })
km.set("n", "<leader><leader>", require("fzf-lua").resume, { desc = "FZF Resume" })
km.set("n", "<leader>r", require("fzf-lua").registers, { desc = "Registers" })
km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })
km.set("n", "<leader>k", require("fzf-lua").keymaps, { desc = "Keymaps" })
km.set("n", "<leader>f", require("fzf-lua").live_grep, { desc = "FZF Grep" })
km.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "FZF Buffers" })
km.set("v", "<leader>8", require("fzf-lua").grep_visual, { desc = "FZF Selection" })
km.set("n", "<leader>7", require("fzf-lua").grep_cword, { desc = "FZF Word" })
km.set("n", "<leader>j", require("fzf-lua").helptags, { desc = "Help Tags" })
km.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })
km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })
km.set("n", "<leader>s", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })
km.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })
km.set(
  "n",
  "<leader>cs",
  ":lua require'fzf-lua'.lsp_document_symbols({winopts = {preview={wrap='wrap'}}})<cr>",
  { desc = "Document Symbols" }
)
km.set("n", "<leader>cr", require("fzf-lua").lsp_references, { desc = "LSP References" })
km.set(
  "n",
  "<leader>cd",
  ":lua require'fzf-lua'.diagnostics_document({fzf_opts = { ['--wrap'] = true }})<cr>",
  { desc = "Document Diagnostics" }
)
km.set(
  "n",
  "<leader>ca",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
  { desc = "Code Actions" }
)


km.set("n", "<leader>ch", function()
  vim.lsp.buf.hover()
end, { desc = "Code Hover" })

km.set("n", "<leader>cl", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Line Diagnostics" })

km.set({ "v", "n" }, "<leader>cn", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Code Rename" })

--nav buddy
km.set({ "n" }, "<leader>xb", ":lua require('nvim-navbuddy').open()<cr>", { desc = "Nav Buddy" })

km.set("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

-- Easier window switching with leader + Number
-- Creates mappings like this: km.set("n", "<Leader>2", "2<C-W>w", { desc = "Move to Window 2" })
for i = 1, 4 do
  local lhs = "<Leader>" .. i
  local rhs = i .. "<C-W>w"
  km.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

-- Gitsigns specific for file specific git info/tools
km.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Git toggle line blame" })
km.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
km.set("n", "<leader>gr", ":Gitsigns reset_hunk<cr>", { desc = "Get reset hunk" })

-- This allows you to select, and paste over contents, without that pasted over contents going into the register, that means you can paste again without it inserting the thing you pasted over the last time
km.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

km.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

km.set({ "n" }, "<Leader>xw", function()
  return Snacks.notify.notify(wordCount.getWords(), {
    zindex = 1000,
    title = "Word Count",
    timeout = 3000,
    icon = "󰆙 ",
  })
end, { desc = "Word Count" })

-- get the file format of the current file
km.set({ "n" }, "<Leader>xt", function()
  local symbols = {
    unix = " LF",
    dos = " CRLF",
    mac = " CR",
  }

  local ft = vim.bo.fileformat
  local output = string.format("%s%s", ft, symbols[ft])
  return Snacks.notify.notify(output, {
    icon = " ",
    title = "File Type",
    timeout = 2000,
    zindex = 1000,
  })
end, { desc = "Show File Format" })

-- Toggle Terminal, thanks https://www.reddit.com/r/neovim/comments/1bjhadj/efficiently_switching_between_neovim_and_terminal/
exitTerm = function()
  vim.cmd(":lua Snacks.terminal.toggle()")
end
km.set({ "n" }, "<C-t>", ":lua Snacks.terminal.toggle()<cr>", { desc = "Toggle Terminal" })
km.set({ "t" }, "<C-t>", exitTerm)

-- km.set("n", "<leader>l", ":LazyGit<cr>", { silent = true, desc = "Lazygit" })
km.set("n", "<leader>l", ":lua Snacks.lazygit.open()<cr>", { silent = true, desc = "Lazygit" })

-- Easy delete buffer without losing window split
km.set("n", "<leader>d", ":lua Snacks.bufdelete.delete()<cr>", { silent = true, desc = "Buffer Delete" })

-- Zen Mode
Snacks.toggle.zen():map("<leader>z")

-- Show Notifier history
km.set("n", "<leader>xh", ":lua Snacks.notifier.show_history()<cr>", { silent = true, desc = "Notifier history" })
