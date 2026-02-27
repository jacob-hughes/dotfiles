return {
	"saghen/blink.cmp",
	lazy = false,
	enabled = true,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v1.*",
	opts = {
		keymap = { preset = "default" },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				},
			},
			menu = {
				border = "rounded",
				draw = { gap = 2 },
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
			},
		},
		sources = {
			default = { "snippets", "lsp", "path", "buffer" },
		},
		snippets = { score_offset = 0 },

		signature = { enabled = true },
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
}
