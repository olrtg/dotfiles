local api = require("user.utils.api")

api.install_plugins({
  { "lvimuser/lsp-inlayhints.nvim" },
})

api.setup_plugin("lsp-inlayhints", nil, function()
  vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
  vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      require("lsp-inlayhints").on_attach(client, bufnr)
    end,
  })
end)
