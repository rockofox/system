local hasTreesitter, _ = pcall(require, "nvim-treesitter")

if hasTreesitter then
    local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
    vim.fn.mkdir(parser_install_dir, "p")
    vim.opt.runtimepath:append(parser_install_dir)
    require'nvim-treesitter.configs'.setup{
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = { "kotlin", "bash", "lua", "vim" },
        },
        indent = {
            enable = true,
        },
        parser_install_dir = parser_install_dir
    }
end
