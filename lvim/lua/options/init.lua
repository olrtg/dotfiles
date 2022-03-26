-- General
lvim.log.level = "warn"

lvim.format_on_save = true

lvim.colorscheme = "nord"

lvim.lsp.diagnostics.virtual_text = false -- disable inline diagnostics

vim.opt.relativenumber = true

lvim.leader = "space"

-- Builtins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = false

lvim.builtin.notify.active = true

lvim.builtin.terminal.active = true

lvim.builtin.dap.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.view.width = 40

lvim.builtin.treesitter.highlight.enabled = true
