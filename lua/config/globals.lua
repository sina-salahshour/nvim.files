vim.loader.enable()

vim.g.no_lsp = os.getenv("NO_LSP") ~= "true"

vim.opt.exrc = true

-- bidi support in cosmic term

vim.opt.termbidi = true
vim.cmd([[
set nofoldenable
]])

-- neovide config

vim.o.pumblend = 20
vim.o.winblend = 20
vim.o.pumheight = 10
vim.g.neovide_transparency = 0.6
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_trail_size = 0.1

-- neovide config end
vim.g.filetype_pl = "prolog"

-- fold config

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- prolog file type
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true
vim.opt.termguicolors = true

-- line numbers
-- vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.mouse = ""

-- vim.o.textwidth = 80
vim.o.ruler = true
vim.o.colorcolumn = "81"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.hlsearch = true
