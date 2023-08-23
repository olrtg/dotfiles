-- [nfnl] Compiled from fnl/plugins/neotree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local neotree = require("neo-tree")
  return neotree.setup()
end
return {{"nvim-neo-tree/neo-tree.nvim", version = "v3.x", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, config = _1_}}
