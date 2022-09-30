lvim.log.level = "warn"

lvim.format_on_save = true
-- lvim.format_on_save.timeout = 2000

vim.g.catppuccin_flavour = "frappe"
lvim.colorscheme = "catppuccin"

lvim.lsp.diagnostics.virtual_text = false -- disable inline diagnostics

vim.opt.relativenumber = true

lvim.leader = "space"

-- Builtins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.breadcrumbs.active = true

lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 40

lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.lualine.options.globalstatus = true
