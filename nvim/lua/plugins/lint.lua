-- [nfnl] Compiled from fnl/plugins/lint.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local lint = require("lint")
  lint.linters_by_ft = {javascript = {"eslint_d"}, typescript = {"eslint_d"}, typescriptreact = {"eslint_d"}, javascriptreact = {"eslint_d"}}
  return nil
end
return {{"mfussenegger/nvim-lint", config = _1_}}
