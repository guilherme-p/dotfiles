-- vim.keymap.set({"n", "v"}, ";", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = ";"
vim.g.maplocalleader = " ";

vim.loader.enable()
require('options')
require('plugins')
require('keymaps')
