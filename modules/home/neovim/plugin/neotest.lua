require("neotest").setup({
	adapters = {
		require("neotest-haskell") {
            build_tools = { 'cabal' },
        }
	}
})

vim.keymap.set("n", "<leader>tt", function()
    require("neotest").run.run()
end)
vim.keymap.set("n", "<leader>to", function()
    require("neotest").output.open {
        enter = true,
        open_win = function(settings)
            local height = math.min(settings.height, vim.o.lines - 2)
            local width = math.min(settings.width, vim.o.columns - 2)
            return vim.api.nvim_open_win(0, true, {
                relative = "editor",
                row = 7,
                col = (vim.o.columns - width) / 2,
                width = width,
                height = height,
                style = "minimal",
                border = vim.g.floating_window_border,
                noautocmd = true,
            })
        end,
    }
end)
vim.keymap.set("n", "<leader>ts", function()
    require("neotest").summary.toggle()
end)
vim.keymap.set("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand "%")
end)
vim.keymap.set("n", "<leader>td", function()
    require("neotest").run.run { strategy = "dap" }
end)
vim.keymap.set("n", "<leader>tw", function()
    require("neotest").watch.watch()
end)
