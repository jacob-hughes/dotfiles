return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	enabled = true,
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				sh = { "shfmt", lsp_format = "fallback" },
				c = { "clang_format" },
				cpp = { "clang_format" },
			},

			format_on_save = nil,
		})
	end,
}
