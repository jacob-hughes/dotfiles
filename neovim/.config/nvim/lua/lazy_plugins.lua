-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
	return function()
		require("plugins." .. name)
	end
end

local required_plugins = {
	{ "rebelot/kanagawa.nvim", config = get_setup("kanagawa"), priority = 1000, lazy = false },
	{ "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
	-- { "airblade/vim-rooter" }, -- Change the root directory when opening a file
	{ "ntpeters/vim-better-whitespace" }, -- Red highlight for trailing whitespace
	{ "alexghergh/nvim-tmux-navigation", config = get_setup("nvim-tmux-navigation") },
	{ "numToStr/Comment.nvim", lazy = false, config = get_setup("comment") },
	{
		"folke/which-key.nvim",
		config = get_setup("which-key"),
		event = "VeryLazy",
	},
	{ "brenoprata10/nvim-highlight-colors", config = get_setup("highlight-colors") },
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
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = require("plugins.snacks"),
	},
}
--
local full_plugins = {
	{
		"nvim-treesitter/nvim-treesitter",
		config = get_setup("treesitter"),
		build = ":TSUpdate",
		event = "BufReadPost",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Extra stuff for treesitter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = get_setup("conform"),
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
		"folke/neoconf.nvim",
		lazy = false,
		config = function()
			require("neoconf").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = get_setup("lsp"),
		dependencies = { "saghen/blink.cmp", "folke/neoconf.nvim" },
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = get_setup("mason-lspconfig"),
	},
	{
		"neogitOrg/neogit",
		config = get_setup("neogit"),
		dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	},
}

local all_plugins = {}

-- Add all plugins from required_plugins
for _, plugin in ipairs(required_plugins) do
	table.insert(all_plugins, plugin)
end

if not minimal_config then
	-- Add all plugins from full_plugins
	for _, plugin in ipairs(full_plugins) do
		table.insert(all_plugins, plugin)
	end
end

return all_plugins
