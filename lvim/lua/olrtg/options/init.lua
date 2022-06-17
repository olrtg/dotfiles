-- General
lvim.log.level = "warn"

lvim.format_on_save = true

vim.o.background = "dark"
vim.g.everforest_background = "dark"
vim.g.everforest_better_performance = 1
lvim.colorscheme = "everforest"
lvim.transparent_window = true

lvim.lsp.diagnostics.virtual_text = false -- disable inline diagnostics

vim.opt.relativenumber = true

vim.opt.cmdheight = 1

lvim.leader = "space"

-- Builtins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.dashboard.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

lvim.builtin.notify.active = true

lvim.builtin.terminal.active = true

lvim.builtin.dap.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 40

lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true
