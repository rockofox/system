local hasBufferline, _ = pcall(require, "bufferline")
if hasBufferline then
    require('bufferline').setup {
        options = {
            diagnostics = "nvim_lsp",
            middle_mouse_command = "bdelete! %d",
            show_close_icon = false,
            show_buffer_close_icons = true,
            hover = { enabled = true, reveal = { 'close' } },
            indicator = {
                style = "underline",
            },
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "",
                    highlight = 'NvimTreeNormal',
                    --separator = '▏',
                }
            },
        },
        highlights = {
            -- offset_separator = {
            --     bg = '#06080A'
            -- },
            -- indicator_selected = {
            --     fg = '#f24f72',
            --     bg = 'bg'
            -- },
            -- fill = {
            --     fg = 'bg',
            --     bg = '#242528'
            -- },
            -- background = {
            --     bg = '#242528'
            -- },
            -- close_button = {
            --     bg = '#242528'
            -- },
            -- close_button_visible = {
            --     bg = '#242528'
            -- },
            -- close_button_selected = {
            --     bg = 'bg'
            -- },
            -- separator = {
            --     bg = '#242528'
            -- },
            -- tab_close = {
            --     fg = '#ccccee',
            --     bg = '#ec5f67'
            -- },
        },
    }

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n','gD', '<Cmd>BufferLinePickClose<CR>', opts)
    vim.keymap.set('n','gB', '<Cmd>BufferLinePick<CR>', opts)
    vim.keymap.set('n','<leader><tab>', '<Cmd>BufferLineCycleNext<CR>', opts)
    vim.keymap.set('n','<S-tab>', '<Cmd>BufferLineCyclePrev<CR>', opts)
    vim.keymap.set('n','[b', '<Cmd>BufferLineMoveNext<CR>', opts)
    vim.keymap.set('n',']b', '<Cmd>BufferLineMovePrev<CR>', opts)
    vim.keymap.set('n','<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', opts)
    vim.keymap.set('n','<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', opts)
    vim.keymap.set('n','<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', opts)
    vim.keymap.set('n','<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', opts)
    vim.keymap.set('n','<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', opts)
    vim.keymap.set('n','<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', opts)
    vim.keymap.set('n','<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', opts)
    vim.keymap.set('n','<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', opts)
    vim.keymap.set('n','<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', opts)
end
