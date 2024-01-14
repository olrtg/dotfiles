-- NOTE:
-- This are customizations that fixes some problems that I had
return {
  -- Don't show a message if hover is not available
  -- ex: shift+k on Typescript code
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          silent = true,
        },
      },
    },
  },
}
