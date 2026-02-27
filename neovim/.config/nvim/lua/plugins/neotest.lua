return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest"),
			},
		})

		vim.keymap.set("n", "<leader>tr", function()
			require("neotest").run.run()
		end, { desc = "Debug: Running Nearest Test" })

		vim.keymap.set("n", "<leader>td", function()
			require("neotest").run.run({ strategy = "dap" })
		end, { desc = "Debug: Debug Nearest Test" })

		vim.keymap.set("n", "<leader>ta", function()
			require("neotest").run.run({ suite = true })
		end, { desc = "Run all tests" })

		vim.keymap.set("n", "<leader>to", function()
			require("neotest").output.open()
		end, { desc = "Debug: Open test output" })

		vim.keymap.set("n", "<leader>tf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { desc = "Run tests in current file" })

		vim.keymap.set("n", "<leader>ts", function()
			require("neotest").summary.toggle()
		end, { desc = "Toggle test summary" })
	end,
}
