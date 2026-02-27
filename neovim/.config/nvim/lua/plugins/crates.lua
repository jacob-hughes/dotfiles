return {
	"saecki/crates.nvim",
	config = function()
		require("crates").setup({
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
			completion = {
				crates = {
					enabled = true,
					min_chars = 3,
					max_results = 8,
				},
			},
		})
	end,
}
