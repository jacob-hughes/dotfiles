local minimal = vim.env.NVIM_MINIMAL == "1" or vim.g.minimal_config == true

return {
	{ "folke/neoconf.nvim" },
	{ "folke/trouble.nvim", opts = {} },
}
