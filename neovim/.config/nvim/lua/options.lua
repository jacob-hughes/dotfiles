local indent = 4
local opt = vim.opt -- to set options
opt.winborder = "single"
opt.backspace = { "indent", "eol", "start" }
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.cursorcolumn = true
opt.foldenable = true
opt.foldmethod = "manual"
-- opt.formatoptions = "l"
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- Get a preview of replacements
opt.joinspaces = false -- No double spaces with join
vim.o.lazyredraw = true
opt.linebreak = true -- Stop words being broken on wrap
opt.number = true -- Show line numbers
opt.listchars = { tab = " ", trail = "·", nbsp = "%" }
opt.list = true -- Show some invisible characters
opt.relativenumber = true

opt.equalalways = true -- make windows the same width when closing one
opt.cursorlineopt = "both" -- should get cursorline in number too

opt.expandtab = true
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent
--
vim.o.shortmess = vim.o.shortmess .. "sWIcF" -- stops display of currentsearch match in cmdline area
opt.showmode = false -- Don't display mode
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes:1" -- always show signcolumns
opt.smartcase = true -- Do not ignore case with capitals
opt.spelllang = { "en_gb" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
-- opt.splitkeep = "screen" -- Stops screen jumping when splits below are opened
opt.title = true -- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'
-- Give me some fenced codeblock goodness
vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
opt.wrap = true
-- opt.cc = "80"
opt.guicursor =
	"n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
-- vim.notify = require("notify")
opt.jumpoptions = "view"
opt.timeoutlen = 300 -- The time before a key sequence should complete
opt.cpoptions:append(">") -- when you yank multiple times into a register, this puts each on a new line
opt.nrformats:append("alpha") -- this means you can increment lists that have letters with `g ctrl-a`
opt.ph = 15 -- the number is the number of entries to show before scrollbars, not px!
opt.virtualedit = "block" -- allows using visual blocks beyond the end of a line
opt.pumblend = 5 -- partial opacity of pop up menu, this causes characters in lspkind to render incorrect width and means that you have to set up kitty to use narrow symbols. See https://github.com/kovidgoyal/kitty/discussions/7774#discussioncomment-10442608
local api = vim.api
-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	group = yankGrp,
	pattern = "*",
	callback = function()
		vim.hl.on_yank()
	end,
	desc = "Highlight yank",
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)
-- show cursor col line only in active window
local cursorColGrp = api.nvim_create_augroup("CursorColumn", { clear = true })
api.nvim_create_autocmd(
	{ "InsertLeave", "WinEnter" },
	{ pattern = "*", command = "set cursorcolumn", group = cursorColGrp }
)
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorcolumn", group = cursorColGrp }
)

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

-- Create an augroup to avoid duplicate autocmds on reload
local group = api.nvim_create_augroup("TrimWhitespaceOnSave", { clear = true })

api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*",
	callback = function()
		if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") ~= "true\n" then
			return
		end
		local file = vim.fn.expand("%:p")
		local lines = vim.fn.systemlist(
			string.format(
				'git diff --unified=0 --no-color -- %s | grep -E "^\\+[0-9]+" | sed -E "s/^\\+([0-9]+).*/\\1/"',
				vim.fn.shellescape(file)
			)
		)
		if vim.v.shell_error ~= 0 then
			return
		end
		local bufnr = api.nvim_get_current_buf()
		for _, l in ipairs(lines) do
			local n = tonumber(l)
			if n then
				local c = api.nvim_buf_get_lines(bufnr, n - 1, n, false)[1]
				if c then
					api.nvim_buf_set_lines(bufnr, n - 1, n, false, { c:gsub("%s+$", "") })
				end
			end
		end
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

-- Show trailing whitespace as bright red
vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Substitute" })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = [[
    syntax clear TrailingWhitespace |
    syntax match TrailingWhitespace /\s\+$/
  ]],
})

vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions[1].type == "move" then
			Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
		end
	end,
})

-- This is global settings for diagnostics
vim.o.updatetime = 250
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰳦 ",
			[vim.diagnostic.severity.HINT] = "󱡄 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
