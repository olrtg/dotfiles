local api = require("user.utils.api")

api.override_servers({ "fennel_language_server" })

api.install_tools({ "fennel-language-server" })

api.install_plugins({
  { "Olical/conjure" },
  {
    "PaterJason/cmp-conjure",
    config = function()
      vim.list_extend(lvim.builtin.cmp.sources, { { name = "conjure" } })
    end,
  },
})

api.install_parsers({ "fennel" })

api.setup_formatters({
  { command = "fnlfmt" },
})

require("lvim.lsp.manager").setup("fennel_language_server", {
  settings = {
    fennel = {
      workspace = {
        -- If you are using hotpot.nvim or aniseed,
        -- make the server aware of neovim runtime files.
        library = vim.api.nvim_list_runtime_paths(),
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
