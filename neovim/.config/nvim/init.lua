-- Map leader to comma. This lets me do a lot of shortcuts using both hands
vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "plugins",
	change_detection = { notify = false },
})

-- vim.cmd.colorscheme("kanagawa-wave")

require("options")
require("mappings")
vim.cmd("colorscheme kanagawa")

-- Define copy and paste functions for OSC52
local function copy(lines, _)
	local text = table.concat(lines, "\n")
	local osc52 = "\x1b]52;c;" .. vim.fn.system("base64", text):gsub("\n", "") .. "\x07"
	vim.fn.chansend(vim.v.stderr, osc52)
end

local function paste()
	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

-- Set up the clipboard provider to use OSC52
vim.g.clipboard = {
	name = "osc52",
	copy = { ["+"] = copy, ["*"] = copy },
	paste = { ["+"] = paste, ["*"] = paste },
}

-- Optional: Use the '+' register by default for yanking and pasting
vim.opt.clipboard = "unnamedplus"
