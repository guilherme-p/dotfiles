vim.keymap.set("n", ";", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = ";"

vim.loader.enable()
require('options')
require('plugins')
require('keymaps')
