local neogit = require('neogit')
local opts = { noremap = true, silent = true }

neogit.setup {}

vim.api.nvim_set_keymap('n', '<leader>bd', '<cmd>bd<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Neogit<CR>', opts)
