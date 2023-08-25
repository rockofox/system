vim.opt.runtimepath:append("$HOME/.config/nvim/treesitter")

require'nvim-treesitter.configs'.setup {
    parser_install_dir = "$HOME/.config/nvim/treesitter", -- For some reason, treesitter doesn't work properly for me when installing via Nix
    ensure_installed = "all",

    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
