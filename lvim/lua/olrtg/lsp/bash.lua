local bash_opts = {
  filetypes = { "sh", "zsh" },
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zsh|.zshrc|zshrc|zsh_*)",
  },
}

require("lvim.lsp.manager").setup("bashls", bash_opts)
