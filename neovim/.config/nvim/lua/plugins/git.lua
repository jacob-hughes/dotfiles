return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		enabled = true,
		config = function()
			require("gitsigns").setup({
				current_line_blame_opts = {
					delay = 0,
				},
			})
		end,
	},

	{
		"sindrets/diffview.nvim",
		enabled = true,
		config = function()
			require("diffview").setup({
				keymaps = {
					view = {
						{ "n", "q", ":DiffviewClose<cr>", { desc = "Close diffview" } },
					},
					file_history_panel = {
						{ "n", "q", ":DiffviewClose<cr>", { desc = "Close diffview" } },
					},
				},
			})
		end,
		keys = {
			{ "<Leader>gdr", ":DiffviewFileHistory <cr>", desc = "Diff repo" },
			{ "<Leader>gdf", ":DiffviewFileHistory --follow %<cr>", desc = "Diff file" },
		},
	},
}
