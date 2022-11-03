require'lspconfig'.html.setup{
		on_attach = require'on-attach',
}
require'lspconfig'.angularls.setup{
		on_attach = require'on-attach',
}
require'lspconfig'.tsserver.setup{
		on_attach = require'on-attach',
}
