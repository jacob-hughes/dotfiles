return {
	"numToStr/Comment.nvim",
	lazy = false,
	enabled = true,
	config = function()
		require("Comment").setup({
			toggler = {
				line = "<C-/>",
				block = "<C-?>",
			},
			opleader = {
				line = "<C-/>",
				block = "<C-?>",
			},
		})
	end,
}
