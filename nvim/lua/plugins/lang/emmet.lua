return {
  { "neovim/nvim-lspconfig", opts = { servers = { emmet_language_server = {} } } },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "emmet-language-server" })
    end,
  },

  { "olrtg/nvim-emmet", dev = true },
}
