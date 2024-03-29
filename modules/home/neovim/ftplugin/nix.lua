vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4

local caps = vim.tbl_extend(
  'keep',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
);

require('lspconfig').nil_ls.setup {
  autostart = true,
  capabilities = caps,
  cmd = { 'nil' },
  settings = {
    ['nil'] = {
      testSetting = 42,
      formatting = {
	command = { "nixfmt" },
      },
    },
  },
}
