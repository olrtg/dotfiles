-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

vim.o.smartcase = true
vim.o.ignorecase = true

-- Configure how new splits should be opened
vim.o.splitbelow = true
vim.o.splitright = true

-- Save undo history
vim.opt.undofile = true

-- Preview substitutions live as you type
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Sets how Neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { eol = "↵", nbsp = "◇", tab = "→ ", trail = "⋅" }

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Make line numbers default
vim.opt.number = true

-- Disable line wrapping
vim.o.wrap = false

vim.cmd("packadd cfilter")
