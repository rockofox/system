require'lspconfig'.html.setup{
	on_attach = require'on-attach',
	cmd = { "html-languageserver", "--stdio" },
}
require'lspconfig'.cssls.setup{
	on_attach = require'on-attach',
	cmd = { "css-languageserver", "--stdio" },
}
require'lspconfig'.angularls.setup{
		on_attach = require'on-attach',
}
require'lspconfig'.ts_ls.setup{
		on_attach = require'on-attach',
}
