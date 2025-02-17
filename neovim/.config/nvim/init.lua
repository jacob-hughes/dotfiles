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


