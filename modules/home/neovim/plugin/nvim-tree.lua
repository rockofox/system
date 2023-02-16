require 'nvim-tree'.setup {
	open_on_tab = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = "  ",
			symlink_arrow = " → ",
			show = {
				file = true,
				folder = true,
				folder_arrow = false,
				git = false,
			},
		},
	},
	filesystem_watchers = {
		enable = true,
	},
}
local function open_nvim_tree()
  -- open the tree
  require("nvim-tree.api").tree.open()
end

-- Automatically close the tab/vim when nvim-tree is the last window in the tab
vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('CloseNvimTreeWhenLast', {}),
	command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
	nested = true,
})
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', opts)
