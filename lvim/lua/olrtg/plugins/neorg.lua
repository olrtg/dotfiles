local M = {}

M.config = function()
  local status_ok, neorg = pcall(require, "neorg")

  if not status_ok then
    return
  end

  local icons = require("olrtg.plugins.icons")

  -- https://github.com/nvim-neorg/neorg
  local options = {
    load = {
      ["core.defaults"] = {},

      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            main = "~/notes/main",
            tasks = "~/notes/tasks",
          },
        },
      },

      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },

      ["core.norg.journal"] = {
        config = {
          workspace = "main",
          strategy = "flat",
        },
      },

      ["core.gtd.base"] = {
        config = {
          workspace = "tasks",
        },
      },

      ["core.norg.concealer"] = {
        config = {
          icons = {
            todo = icons.todo,
            list = icons.list,
            heading = icons.heading,
          },
          dim_code_blocks = {
            width = "content", -- Default is "fullwidth"

            padding = {
              left = 10,
              right = 10,
            },
          },
        },
      },
    },
  }

  neorg.setup(options)
end

return M
