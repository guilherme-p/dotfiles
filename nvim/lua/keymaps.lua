local keymap = vim.keymap
keymap.set({ "n" }, "<leader>w", "<C-c>:update<cr>", { silent = true, desc = "Save" })
keymap.set("n", "<leader>q", ":q<cr>")
keymap.set({ "n", "v", "o" }, "<C-D>", "<C-D>zz")
keymap.set({ "n", "v", "o" }, "<C-U>", "<C-U>zz")
keymap.set({ "n", "v", "o" }, "H", "^")
keymap.set({ "n", "v", "o" }, "L", "$")
keymap.set({ "n", "v", "o" }, "J", "}")
keymap.set({ "n", "v", "o" }, "K", "{")
keymap.set({ "n" }, "<Esc>", "<Esc>:noh<cr>", { silent = true })

keymap.set({ "n", "v" }, "<C-q>", "q")
keymap.set({ "n", "v" }, "q", "<nop>")

-- delete without yanking
keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- replace currently selected text with default register
-- without yanking it
keymap.set({ "n", "v", }, "<leader>p", '"_dP')

local telescope = require('telescope.builtin')
keymap.set("n", '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
keymap.set("n", '<leader>sr', telescope.oldfiles, { desc = '[S]earch [R]ecent' })
keymap.set("n", '<leader>sgf', telescope.git_files, { desc = '[S]earch [G]it [F]iles' })
keymap.set("n", '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
keymap.set("n", '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
keymap.set("n", '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })

keymap.set("n", '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap.set('n', '<leader>do', vim.diagnostic.open_float)
keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev)
keymap.set('n', '<leader>dj', vim.diagnostic.goto_next)

keymap.set("n", '<leader>sb', telescope.buffers, { desc = '[S]earch [B]uffers'})
keymap.set("n", '<leader>sk', telescope.keymaps, { desc = '[S]earch [K]eymaps'})

keymap.set("n", '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
keymap.set("n", '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

keymap.set("n", 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
keymap.set("n", 'gr', telescope.lsp_references, { desc = '[G]oto [R]eferences' })
keymap.set("n", 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
keymap.set("n", '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
keymap.set("n", '<leader>sds', telescope.lsp_document_symbols, { desc = '[S]earch [D]ocument [S]ymbols' })
keymap.set("n", '<leader>sws', telescope.lsp_dynamic_workspace_symbols, { desc = '[S]earch [W]orkspace [S]ymbols' })

keymap.set("n", '<leader>hd', vim.lsp.buf.hover, { desc = 'Hover Documentation' })

-- Lesser used LSP functionality
keymap.set("n", 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

keymap.set("n", "<leader>to", ":tabnew ") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab

keymap.set("n", "<leader>bx", ":bd<CR>") -- close current buffer
keymap.set("n", "<leader>bo", ":e ") -- open new file in buffer

keymap.set("n", "<leader>/", ":%s/")

keymap.set("n", "<Tab>", ":bnext<CR>")
keymap.set("n", "<S-Tab>", ":bprevious<CR>")

keymap.set("n", ">", ">>")
keymap.set("n", "<", "<<")
keymap.set("v", ">", ">gv")
keymap.set("v", "<", "<gv")
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
keymap.set("n", "<C-j>", ":m .+1<CR>==")
keymap.set("n", "<C-k>", ":m .-2<CR>==")
