local opt = vim.opt
local g = vim.g
local fn = vim.fn

-- Use space as leader key
g.mapleader = ' '

-- Set mouse mode to all modes
opt.mouse = 'a'

opt.encoding = "utf-8"

opt.updatetime = 100

-- Backspace works on every char in insert mode
vim.opt.backspace = "indent,eol,start"

-- Enable background buffer
vim.o.hidden = true

-- Show line numbers
vim.opt.number = true

-- Share the sign column with the number column to prevent text flicker
--vim.opt.signcolumn = 'number'
vim.opt.signcolumn = 'yes'

-- Display command in bottom bar
vim.opt.showcmd = true

-- Tab control
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Autoindent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
opt.ignorecase = true -- case insensitive searching
opt.smartcase = true -- case-sensitive if expresson contains a capital letter
opt.hlsearch = true -- highlight search results
opt.incsearch = true -- set incremental search, like modern browsers
opt.lazyredraw = false -- don't redraw while executing macros
opt.magic = true -- set magic on, for regular expressions

-- If ripgrep installed, use that as a grepper
if fn.executable("rg") then
	opt.grepprg = "rg --vimgrep --no-heading"
	opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- Show matching brackets
vim.o.showmatch = true

-- Split direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }

-- Prevent strange file save behaviour.
-- https://github.com/srid/emanote/issues/180
vim.opt.backupcopy = 'yes'

-- Use system clipboard
vim.opt.clipboard = 'unnamed'

-- Don't wrap
vim.o.wrap = false

-- Reclaim the empty space at the bottom
vim.o.cmdheight = 0

-- Disable fill characters ('~')
vim.o.fillchars='eob: '
