local keymap = vim.keymap

keymap.set({ "n" }, "<leader>w", ":update<cr>", { silent = true, desc = "Save" })
keymap.set({ "n" }, "<leader>q", ":q<cr>")
keymap.set({ "n", "v", "o" }, "<C-D>", "<C-D>zz")
keymap.set({ "n", "v", "o" }, "<C-U>", "<C-U>zz")
keymap.set({ "n", "v", "o" }, "H", "^")
keymap.set({ "n", "v", "o" }, "L", "$")
keymap.set({ "n", "v", "o" }, "J", "}")
keymap.set({ "n", "v", "o" }, "K", "{")

keymap.set({ "n" }, "<Esc>", "<Esc>:noh<cr>", { silent = true })

keymap.set({ "n", "v" }, "Q", "q")
keymap.set({ "n", "v" }, "q", "<nop>")

keymap.set({ "n" }, "n", "nzz")
keymap.set({ "n" }, "N", "Nzz")
keymap.set({ "n" }, ",", "nzz")
keymap.set({ "n" }, "<", "Nzz")

keymap.set({ "n" }, "j", "gj")
keymap.set({ "n" }, "k", "gk")

local hop = require('hop')
local directions = require('hop.hint').HintDirection

keymap.set({ "n", "o" }, 'f', function() hop.hint_char1({ keys = "asdfjkl;eriu,cmvghowpqyt", current_line_only = true }) end)
keymap.set({ "n", "o" }, '<localleader>f', function() hop.hint_char1({ keys = "asdfjkl;eriu,cmvghowpqyt", }) end)

keymap.set({ "n", "o" }, 't', function() hop.hint_char1({ keys = "asdfjkl;eriu,cmvghowpqyt", direction = directions.AFTER_CURSOR, hint_offset = -1, current_line_only = true }) end)
keymap.set({ "n", "o" }, '<localleader>t', function() hop.hint_char1({ keys = "asdfjkl;eriu,cmvghowpqyt", direction = directions.AFTER_CURSOR, hint_offset = -1 }) end)

keymap.set({ "n", "o" }, 's', function() hop.hint_words({ keys = "asdfjkl;eriu,cmvghowpqyt", current_line_only = true }) end)
keymap.set({ "n", "o" }, '<localleader>s', function() hop.hint_words({ keys = "asdfjkl;eriu,cmvghowpqyt" }) end)

keymap.set({ "o" }, 'x', function() hop.hint_words({ keys = "asdfjkl;eriu,cmvghowpqyt", direction = directions.AFTER_CURSOR, hint_offset = -1, current_line_only = true }) end)
keymap.set({ "o" }, 'X', function() hop.hint_words({ keys = "asdfjkl;eriu,cmvghowpqyt", direction = directions.AFTER_CURSOR, hint_offset = -1 }) end)


-- delete and yank
keymap.set({ "n", "v" }, "<leader>d", 'd')

-- stop yanking deletes
keymap.set({ "n", "v" }, "d", '"_d')
keymap.set({ "n", "v" }, "D", '"_D')
keymap.set({ "n", "v" }, "x", '"_x')
keymap.set({ "n", "v" }, "c", '"_c')
keymap.set({ "n", "v" }, "C", '"_C')

-- leave cursor where it yanked in visual mode
keymap.set({ "v" }, "y", 'ygv<Esc>')

-- paste with indent level of current line and leave cursor after paste
keymap.set({ "n", "v" }, "p", "p`[V`]=`]")
keymap.set({ "n", "v" }, "P", "P`[V`]=`]")

keymap.set({ "n", "v" }, "<leader>p", 'p')
keymap.set({ "n", "v" }, "<leader>P", 'P')

local telescope = require('telescope.builtin')
keymap.set("n", '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
keymap.set("n", '<leader>sr', telescope.oldfiles, { desc = '[S]earch [R]ecent' })
keymap.set("n", '<leader>sgf', telescope.git_files, { desc = '[S]earch [G]it [F]iles' })
keymap.set("n", '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
keymap.set("n", '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
keymap.set("n", '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })
keymap.set("n", '<leader>sz', telescope.current_buffer_fuzzy_find, { desc = '[S]earch [F]uzzy' })
keymap.set("n", '<leader>sm', telescope.marks, { desc = '[S]earch [M]arks' })
keymap.set("n", '<leader>ss', ":Telescope luasnip<cr>", { desc = '[S]earch [S]nippets' })

keymap.set("n", '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })

keymap.set('n', '<leader>do', vim.diagnostic.open_float)
keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev)
keymap.set('n', '<leader>dj', vim.diagnostic.goto_next)

keymap.set("n", '<leader>sb', telescope.buffers, { desc = '[S]earch [B]uffers'})
keymap.set("n", '<leader>sk', telescope.keymaps, { desc = '[S]earch [K]eymaps'})

keymap.set("n", "<leader>ut", ":Telescope undo<cr>", { desc = '[U]ndo [T]ree'})

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

keymap.set("n", "<leader>fd", ":Format<CR>", { desc = '[F]ormat [D]ocument'})
-- nvim-tree
keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>") -- toggle file explorer

keymap.set("n", "<leader>to", ":tabnew ") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab

keymap.set("n", "<leader>x", ":bd<CR>") -- close current buffer
keymap.set("n", "<leader>e", ":e ") -- open new file in buffer

keymap.set("n", "<leader>/", ":%s/")

keymap.set("n", "<Tab>", ":bnext<CR>")
keymap.set("n", "<S-Tab>", ":bprevious<CR>")

keymap.set({ "n", "v" }, "+", "<C-a>")
keymap.set({ "n", "v" }, "-", "<C-x>")

keymap.set({ "n", "v" }, "U", "<C-r>")
keymap.set({ "n", "v" }, ";;", ":")

keymap.set("n", "<leader>1", ":LualineBuffersJump 1<CR>")
keymap.set("n", "<leader>2", ":LualineBuffersJump 2<CR>")
keymap.set("n", "<leader>3", ":LualineBuffersJump 3<CR>")
keymap.set("n", "<leader>4", ":LualineBuffersJump 4<CR>")
keymap.set("n", "<leader>5", ":LualineBuffersJump 5<CR>")
keymap.set("n", "<leader>6", ":LualineBuffersJump 6<CR>")
keymap.set("n", "<leader>7", ":LualineBuffersJump 7<CR>")
keymap.set("n", "<leader>8", ":LualineBuffersJump 8<CR>")
keymap.set("n", "<leader>9", ":LualineBuffersJump 9<CR>")

keymap.set("n", "<A-l>", ">>")
keymap.set("n", "<A-h>", "<<")
keymap.set("v", "<A-l>", ">gv")
keymap.set("v", "<A-h>", "<gv")

-- move lines up or down
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap.set("n", "<A-j>", ":m .+1<CR>==")
keymap.set("n", "<A-k>", ":m .-2<CR>==")
