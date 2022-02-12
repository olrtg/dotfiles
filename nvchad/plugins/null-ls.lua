local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   -- webdev stuff
   b.formatting.prettier,
   b.diagnostics.eslint,
   b.diagnostics.jsonlint,

   -- Lua
   b.formatting.stylua,

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,
   }
end

return M
