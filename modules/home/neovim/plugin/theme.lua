-- Pick from here: https://github.com/RRethy/nvim-base16#builtin-colorschemes

require 'lualine'.setup {
	options = {
		-- theme = 'base16',
		icons_enabled = true,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {},
		always_divide_middle = true,
	}
}

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = '› ', trail = '~', extends = '»', precedes = '«', nbsp = '_', }

local signs = {
	{ name = 'DiagnosticSignError', text = '🔥' },
	{ name = 'DiagnosticSignWarn', text = '⚠️' },
	{ name = 'DiagnosticSignHint', text = '💡' },
	{ name = 'DiagnosticSignInfo', text = '🔸' },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config {
	virtual_text = true,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
    -- virtual_text = false,
	float = {
		focusable = false,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
}
-- require("lsp_lines").setup()
