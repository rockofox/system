require("toggleterm").setup{
    open_mapping = [[<leader>t]],
    insert_mappings = false,
    terminal_mappings = false
}
vim.api.nvim_create_autocmd(
    "InsertLeave",
    { command = "update" }
)

