return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>y",
			function()
				require("fzf-lua").grep_visual()
			end,
			mode = "v",
			desc = "Grep selection",
		},
	},
	config = function()
		require("fzf-lua").setup({
			defaults = {
				git_icons = false,
				file_icons = false,
				color_icons = false,
			},
		})
	end,
}
