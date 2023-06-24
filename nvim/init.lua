vim.keymap.set("n", ";", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = ";"

require('impatient')
require('options')
require('plugins')
require('keymaps')
