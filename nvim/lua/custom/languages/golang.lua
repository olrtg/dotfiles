local api = require("custom.api")

api.install_parsers({ "go", "gomod", "gowork", "gosum" })

api.install_tools({ "goimports", "gofumpt" })

-- api.setup_formatters({
-- 	{ command = "goimports" },
-- 	{ command = "gofumpt" },
-- })

-- api.install_plugins({
--   {
--     "ray-x/go.nvim",
--     dependencies = {
--       "ray-x/guihua.lua",
--       "neovim/nvim-lspconfig",
--       "nvim-treesitter/nvim-treesitter",
--     },
--     config = function()
--       require("go").setup()
--     end,
--     event = { "CmdlineEnter" },
--     ft = { "go", "gomod" },
--     build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
--   },
-- })
