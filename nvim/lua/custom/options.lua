vim.opt.breakindent = true -- Enable break indent
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Make line numbers default
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.showmode = false -- Don't show the mode, since it's already in status line
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
