-- Map leader to comma. This lets me do a lot of shortcuts using both hands
vim.g.mapleader = ","

_G.minimal_config = vim.env.NVIM_MINIMAL == "true"


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  spec = "lazy_plugins",
  ui = {
    border = "single",
  },
})

require("options")
require("mappings")

-- Define copy and paste functions for OSC52
local function copy(lines, _)
    local text = table.concat(lines, "\n")
    local osc52 = "\x1b]52;c;" .. vim.fn.system("base64", text):gsub("\n", "") .. "\x07"
    vim.fn.chansend(vim.v.stderr, osc52)
end

local function paste()
    return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

-- Set up the clipboard provider to use OSC52
vim.g.clipboard = {
    name = "osc52",
    copy = {["+"] = copy, ["*"] = copy},
    paste = {["+"] = paste, ["*"] = paste},
}

-- Optional: Use the '+' register by default for yanking and pasting
vim.opt.clipboard = "unnamedplus"

