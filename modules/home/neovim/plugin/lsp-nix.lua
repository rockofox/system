require('lspconfig').nil_ls.setup {
  autostart = true,
  capabilities = caps,
  cmd = { lsp_path },
  settings = {
	['nil'] = {
	  testSetting = 42,
	  formatting = {
		command = { "nixpkgs-fmt" },
	  },
	},
  },
}
