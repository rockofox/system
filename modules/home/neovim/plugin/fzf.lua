vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', opts)
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', opts)
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope lsp_definitions<cr>', opts)
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope<cr>', opts)
vim.keymap.set('n', ';', '<cmd>Telescope commands<cr>', opts)
