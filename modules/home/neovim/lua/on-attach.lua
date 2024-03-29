-- on_attach is a function that Neovim's LSP client calls when it connects to a server
-- in a buffer

local opts = { noremap = true, silent = true }

local function on_attach(client, buffer)
	require 'lsp_signature'.on_attach {}
	require("lsp-inlayhints").on_attach(client, buffer)
	-- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	if client.server_capabilities.documentHighlightProvider then
		local group = vim.api.nvim_create_augroup('CursorHighlight', {})
		-- Highlight occurrences under the cursor
		vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			group = group,
			callback = vim.lsp.buf.document_highlight,
			buffer = buffer,
		})
		-- Clear occurrences when the cursor moves
		vim.api.nvim_create_autocmd('CursorMoved', {
			group = group,
			callback = vim.lsp.buf.clear_references,
			buffer = buffer,
		})
	end

	if client.server_capabilities.documentFormattingProvider then
		-- Format the file before it is written
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = vim.api.nvim_create_augroup('FormatOnWrite', {}),
			callback = function() vim.lsp.buf.format(nil, 1000) end,
			buffer = buffer,
		})
	end
end

return on_attach
