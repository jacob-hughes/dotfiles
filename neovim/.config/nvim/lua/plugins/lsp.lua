-- vim.lsp.config("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			runtime = { version = "LuaJIT" },
-- 			diagnostics = { globals = { "vim" } },
-- 			workspace = {
-- 				checkThirdParty = false,
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			telemetry = { enable = false },
-- 		},
-- 	},
-- })
--
-- vim.lsp.enable("lua_ls")

return {
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
        enabled = true,
    },
    {
        "mason-org/mason.nvim",
        enabled = true,
        opts = { automatic_installation = true, automatic_enable = true },
        keys = { {
            "<Leader>em",
            function()
                vim.cmd.Mason()
            end,
            desc = "Open Mason",
        } },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = true,
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
    },
}
