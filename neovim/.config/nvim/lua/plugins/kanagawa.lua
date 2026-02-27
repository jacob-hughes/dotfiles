return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		theme = "wave",
		dimInactive = true,
		compile = false,
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors)
			return {

				IndentBlanklineChar = { fg = colors.palette.waveBlue2 },
				MiniIndentscopeSymbol = { fg = colors.palette.waveBlue2 },
				PmenuSel = { blend = 0 },
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
				CursorLineNr = { bg = colors.theme.ui.bg_p2 },
				Visual = { bg = colors.palette.waveBlue2 },

				-- Save an hlgroup with dark background and dimmed foreground
				-- so that you can use it where your still want darker windows.
				-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
				NormalDark = { fg = colors.theme.ui.fg_dim, bg = colors.theme.ui.bg_m3 },

				-- Popular plugins that open floats will link to NormalFloat by default;
				-- set their background accordingly if you wish to keep them dark and borderless
				LazyNormal = { bg = colors.theme.ui.bg_m3, fg = colors.theme.ui.fg_dim },
			}
		end,
	},
}
