local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.timeoutlen = 1000
opt.termguicolors = true
opt.undofile = true
opt.history = 1000
opt.cursorline = true
