local M = {}

M.config = function()
  local status_ok, headlines = pcall(require, "headlines")

  if not status_ok then
    return
  end

  -- https://github.com/shaunsingh/nord.nvim#headlines-support
  local options = {
    markdown = {
      headline_highlights = {
        "Headline1",
        "Headline2",
        "Headline3",
        "Headline4",
        "Headline5",
        "Headline6",
      },
      codeblock_highlight = "CodeBlock",
      dash_highlight = "Dash",
      quote_highlight = "Quote",
    },
  }

  headlines.setup(options)
end

return M
