-- [nfnl] Compiled from fnl/plugins/copilot.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local copilot = require("copilot")
  return copilot.setup({suggestion = {auto_trigger = true, keymap = {accept = "<M-Enter>", accept_line = "<M-l>", accept_word = "<M-w>", dismiss = "<M-c>", next = "<M-]>", prev = "<M-[>"}}})
end
return {{"zbirenbaum/copilot.lua", config = _1_}}
