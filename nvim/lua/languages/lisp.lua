local x = require("x")

x.install_tools({ "fennel-language-server" })

x.install_plugins({
	{ "Olical/conjure" },
	-- {
	--   "PaterJason/cmp-conjure",
	--   config = function()
	--     vim.list_extend(lvim.builtin.cmp.sources, { { name = "conjure" } })
	--   end,
	-- },
})

x.install_parsers({ "fennel" })

x.setup_formatters({
	{ command = "fnlfmt" },
})

-- require("lvim.lsp.manager").setup("fennel_language_server", {
--   settings = {
--     fennel = {
--       workspace = {
--         -- If you are using hotpot.nvim or aniseed,
--         -- make the server aware of neovim runtime files.
--         library = vim.api.nvim_list_runtime_paths(),
--       },
--       diagnostics = {
--         globals = { "vim" },
--       },
--     },
--   },
-- })
