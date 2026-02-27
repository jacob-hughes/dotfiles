vim.keymap.set("v", "<Leader>qp", function()
    vim.ui.input({ prompt = "AI" }, function(input)
        if input and #input > 0 then
            vim.cmd("'<,'>CodeCompanion #{buffer} " .. input)
        end
    end)
end, { desc = "Query prompt" })

vim.keymap.set("n", "<Leader>qp", function()
    vim.ui.input({ prompt = "AI" }, function(input)
        if input and #input > 0 then
            vim.cmd("CodeCompanion #{buffer} " .. input)
        end
    end)
end, { desc = "Query prompt" })

return {
    "olimorris/codecompanion.nvim",
    lazy = false,
    opts = {
        adapters = {
            http = {
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        schema = {
                            reasoning_effort = { default = "low" }, -- Fast reasoning
                            temperature = { default = 0.2 },
                        },
                    })
                end,
            },
        },
        display = {
            chat = {
                intro_message = "",
                window = { layout = "float" },
                icons = { chat_context = "📎️" },
                fold_context = true,
                show_reasoning = true,
                auto_scroll = false,
            },
        },
        interactions = {
            chat = {
                adapter = {
                    name = "gemini", -- Use custom adapter here
                    model = "gemini-3-flash-preview",
                },
                keymaps = {
                    close = {
                        modes = { n = "q" },
                        index = 4,
                        description = "[Chat] close",
                        callback = function()
                            require("codecompanion").toggle()
                        end,

                    },
                    stop = {
                        modes = { n = "<C-c>" },
                        index = 5,
                        callback = "keymaps.stop",
                        description = "[Request] Stop",
                    },
                },
            },
            inline = {
                adapter = {
                    name = "gemini", -- Use it here too
                    model = "gemini-3-flash-preview",
                },
            },
        },
    },
    keys = {
        { "<Leader>qe", ":'<,'>CodeCompanion #{buffer} Explain the highlighted code. Be concise.<CR>", desc = "Explain selection", mode = "v" },
        { "<Leader>qo", ":CodeCompanionChat Toggle<CR>",                                               desc = "Open AI buffer",    mode = "n" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
