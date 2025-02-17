-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
  return function()
    require("plugins." .. name)
  end
end

return {
	{ "rebelot/kanagawa.nvim", config = get_setup("kanagawa"), priority = 1000, lazy = false },
	{ "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
    { "airblade/vim-rooter"}, -- Change the root directory when opening a file
    { "ntpeters/vim-better-whitespace"}, -- Red highlight for trailing whitespace
    { "alexghergh/nvim-tmux-navigation", config = get_setup("nvim-tmux-navigation")},
	{ "numToStr/Comment.nvim", lazy = false, config = get_setup("comment") },

	{
		"folke/which-key.nvim",
		config = get_setup("which-key"),
		event = "VeryLazy",
	},
	{ "brenoprata10/nvim-highlight-colors", config = get_setup("highlight-colors") },
	{
		"nvim-treesitter/nvim-treesitter",
		config = get_setup("treesitter"),
		build = ":TSUpdate",
		event = "BufReadPost",
	},
	{   "nvim-treesitter/nvim-treesitter-textobjects"}, -- Extra stuff for treesitter
	{   "stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = get_setup("conform"),
	},
    { "folke/neoconf.nvim" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = get_setup("snacks"),
  },
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.5.1",
		opts = require("plugins.blink"),
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = get_setup("gitsigns"),
	},
	{
		"nvim-lualine/lualine.nvim",
		config = get_setup("lualine"),
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		config = get_setup("lsp"),
		dependencies = { "saghen/blink.cmp" },
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^5', -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{ "williamboman/mason.nvim", config = function()
		require("mason").setup()
	end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = get_setup("mason-lspconfig"),

	},
    { "rcarriga/nvim-notify", config = get_setup("notify") },
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = get_setup("fzf"),
	},
	{ "rmagatti/auto-session", config = get_setup("auto-session") },
	{ "echasnovski/mini.ai", config = get_setup("mini-ai"), version = false },
	{ "echasnovski/mini.bracketed", config = get_setup("mini-bracketed"), version = false },
	{ "echasnovski/mini.move", config = get_setup("mini-move"), version = false },
	{
		"windwp/nvim-autopairs",
		config = get_setup("autopairs"),
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
}
