local opts = { noremap = true, silent = true }

-- vim.api.nvim_set_keymap('n', 's', '<Plug>easymotion-s2', opts)
-- vim.api.nvim_set_keymap('n', 't', '<Plug>easymotion-t2', opts)
vim.cmd([[
  nmap s <Plug>(easymotion-s2)
  nmap t <Plug>(easymotion-t2)
]])

vim.g.EasyMotion_verbose = 0
