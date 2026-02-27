return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	enabled = true,
	config = function()
		require("oil").setup({
			columns = {
				"icon",
			},
			skip_confirm_for_simple_edits = true,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		})
	end,
}
