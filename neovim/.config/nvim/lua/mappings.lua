local km = vim.keymap

-- Here is a utility function that closes any floating windows when you press escape
local function close_floating()
    for _, win in pairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative == "win" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })
km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })
km.set("n", "<Delete>", "<cmd>:w<CR>", { desc = "Save file" })

km.set("n", "<esc>", function()
    close_floating()
    vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })
km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })
km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

-- Make visual yanks place the cursor back where started
km.set("v", "y", "ygv<Esc>", { desc = "Yank and reposition cursor" })
-- km.set("n", "<Delete>", "<cmd>:w<CR>", { desc = "Save file" })

vim.keymap.set({ "n", "v", "i" }, "<C-p>", function()
    require("fzf-lua").complete_path()
end, { silent = true, desc = "Fuzzy complete path" })

-- km.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })
-- km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })
km.set("n", "<leader>gb", ":Gitsigns blame<cr>", { desc = "Git blame" })
km.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
km.set("n", "<leader>gr", ":Gitsigns reset_hunk<cr>", { desc = "Get reset hunk" })
km.set("n", "<leader>gd", ":DiffviewOpen<cr>", { desc = "Git diff file" })

km.set("n", "<leader>ch", function()
    vim.lsp.buf.hover()
end, { desc = "Code Hover" })

km.set("n", "<leader>cl", function()
    vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Line Diagnostics" })

km.set("n", "<esc>", function()
    close_floating()
    vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        km.set("n", "gd", require("fzf-lua").lsp_definitions, { buffer = ev.buf, desc = "Jump to definition" })
        km.set("n", "gD", require("fzf-lua").lsp_declarations, { buffer = ev.buf, desc = "Jump to declaration" })
        km.set("n", "gr", require("fzf-lua").lsp_references, { buffer = ev.buf, desc = "Find references" })
        km.set("n", "gi", require("fzf-lua").lsp_implementations, { buffer = ev.buf, desc = "Find implementations" })
        km.set(
            "n",
            "<leader>cd",
            ":lua require'fzf-lua'.diagnostics_document({fzf_opts = { ['--wrap'] = true }})<cr>",
            { buffer = ev.buf, desc = "Show diagnostics" }
        )
        -- Rename but ensure the prompt is empty
        km.set("n", "<leader>cr", function()
            vim.ui.input({ prompt = "New Name: " }, function(input)
                if input and #input > 0 then
                    vim.lsp.buf.rename(input)
                end
            end)
        end, { buffer = ev.buf, desc = "Rename symbol" })
        km.set(
            "n",
            "<leader>ca",
            ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
            { buffer = ev.buf, desc = "Code Actions" }
        )

        -- km.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>cf", function()
            require("conform").format({
                lsp_fallback = true,
                async = true,
                timeout_ms = 2000,
            })
        end, { desc = "Format code" })
        -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        -- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
    end,
})

-- Easier window switching with leader + Number
-- Creates mappings like this: km.set("n", "<Leader>2", "2<C-W>w", { desc = "Move to Window 2" })
for i = 1, 4 do
    local lhs = "<Leader>" .. i
    local rhs = i .. "<C-W>w"
    km.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

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

km.set("n", "<leader>l", ":lua Snacks.lazygit.open()<cr>", { silent = true, desc = "Lazygit" })

-- Easy delete buffer without losing window split
km.set("n", "<leader>d", ":lua Snacks.bufdelete.delete()<cr>", { silent = true, desc = "Buffer Delete" })

-- Zen Mode
Snacks.toggle.zen():map("<leader>z")

-- Show Notifier history
km.set("n", "<leader>xh", ":lua Snacks.notifier.show_history()<cr>", { silent = true, desc = "Notifier history" })
