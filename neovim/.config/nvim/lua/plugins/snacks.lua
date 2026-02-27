return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
        input = {},
		picker = {
			icons = {
				files = {
					enabled = false,
				},
				kinds = {
					Struct = " ",
				},
			},
			layouts = {
				default = {
					layout = {
						box = "horizontal",
						width = 0.8,
						min_width = 120,
						border = "none",
						height = 0.8,
						{
							box = "vertical",
							border = { " ", " ", " ", " ", " ", " ", " ", " " },
							{ win = "list", border = "none" },
							{ win = "input", height = 1, border = "top", title = "{title} {live} {flags}" },
						},
						{
							width = 0.5,
							win = "preview",
							title = "{preview}",
							border = { " ", " ", " ", " ", " ", " ", " ", " " },
							wo = {
								winhighlight = "FloatBorder:SnacksPickerPreview,Normal:SnacksPickerPreview,FloatTitle:SnacksPickerPreviewTitle",
							},
						},
					},
				},
			},
		},
		indent = {
			enabled = true,
			animate = { enabled = false },
		},

		notifier = {
			win = { backdrop = { transparent = false } },
		},

		statuscolumn = { enabled = true },

		toggle = {
			which_key = true,
			notify = true,
			icon = { enabled = " ", disabled = " " },
			color = { enabled = "green", disabled = "yellow" },
		},

		lazygit = {
			os = {
				editCommandTemplate = "{{editor}} -c DiffviewOpen {{filename}}",
			},
		},
	},

	keys = {
		{
			"<leader>p",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>b",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>s",
			function()
				require("snacks").picker.lsp_symbols()
			end,
			desc = "Find workspace symbols",
		},
		{
			"<leader>ws",
			function()
				require("snacks").picker.lsp_workspace_symbols()
			end,
			desc = "Find workspace symbols",
		},

        -- Git options

		{
			"<leader>gs",
			function()
				require("snacks").picker.git_status()
			end,
			desc = "Git status",
		},
		{
			"<leader>gc",
			function()
				require("snacks").picker.git_log_line()
			end,
			desc = "Git log line",
		},
		{
			"<leader>gl",
			function()
				require("snacks").picker.git_log()
			end,
			desc = "Git log repo",
		},
		{
			"<leader>gf",
			function()
				require("snacks").picker.git_log_file()
			end,
			desc = "Git log file",
		},
	},
}
