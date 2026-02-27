return {
	"ibhagwan/fzf-lua",
	enabled = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		-- {
		-- 	"<leader>p",
		-- 	function()
		-- 		require("fzf-lua").files()
		-- 	end,
		-- 	desc = "Find files",
		-- },
		-- {
		-- 	"<leader>b",
		-- 	function()
		-- 		require("fzf-lua").buffers()
		-- 	end,
		-- 	desc = "Find buffers",
		-- },
		{
			"<leader><leader>",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Resume search",
		},
		{
			"<leader>r",
			function()
				require("fzf-lua").registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>m",
			function()
				require("fzf-lua").marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>y",
			function()
				require("fzf-lua").grep_visual()
			end,
			mode = "v",
			desc = "Grep selection",
		},
		{
			"<leader>j",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "Help tags",
		},
		-- {
		-- 	"<leader>f",
		-- 	function()
		-- 		require("fzf-lua").live_grep()
		-- 	end,
		-- 	desc = "Live grep",
		-- },
		{
			"<leader>w",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Grep word",
		},
	},
	config = function()
		require("fzf-lua").setup({
			-- fzf_opts = { ["--wrap"] = true, ["--delimiter"] = "/", ["--nth"] = "1.." },
			grep = {
				rg_glob = true,
				-- first returned string is the new search query
				-- second returned string are (optional) additional rg flags
				-- @return string, string?
				rg_glob_fn = function(query, opts)
					local regex, flags = query:match("^(.-)%s%-%-(.*)$")
					-- If no separator is detected will return the original query
					return (regex or query), flags
				end,
			},
			winopts = {
				-- preview = {
				-- 	wrap = "wrap",
				-- },
			},
			defaults = {
				git_icons = false,
				file_icons = false,
				color_icons = false,
			},
		})
	end,
}
