-- https://github.com/okmanideep/dotfiles/blob/master/nvim/after/plugin/cmp_jira_source.lua

local ok, Job = pcall(require, "plenary.job")
if not ok then
  return
end

local cmp_jira = {
  projects = { "PSP" },
}

local source = {}

local ends_with = function(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

source.new = function()
  local self = setmetatable({ cache = {} }, { __index = source })

  return self
end

source.complete = function(self, params, callback)
  local s = params.context.cursor_before_line
  if not s then
    return nil
  end

  -- s = text before the current cursor position
  local project = self._find_project(s)
  if project == nil then
    return
  end

  if self.cache[project] ~= nil then
    callback({ items = self.cache[project], isIncomplete = false })
  else
    Job
      :new({
        command = "jira",
        args = {
          "issue",
          "list",
          "--plain",
          "--no-headers",
          "--history",
          "--columns=key,type,summary,status,assignee",
          "-p=" .. project,
        },

        on_exit = function(job)
          local result = job:result()
          local tickets = {}
          for _, item in ipairs(result) do
            --replacing tabs with `;` for easier pattern matching
            local subbed = item:gsub("\t", ";")
            local _, _, key, ttype, summary, status, assignee = string.find(subbed, ("([^;]*);*"):rep(5, ";*"))
            table.insert(tickets, {
              label = key,
              documentation = {
                kind = "markdown",
                value = "# " .. summary .. "\n" .. ttype .. "\t" .. assignee .. "\t" .. status,
              },
            })
          end

          self.cache[project] = tickets
          callback({ items = tickets, isIncomplete = false })
        end,
      })
      :start()
  end
end

source.get_trigger_characters = function()
  return { "-" }
end

source.is_available = function()
  return true
end

source._find_project = function(text)
  for _, project in ipairs(cmp_jira.projects) do
    if ends_with(text, project .. "-") then
      return project
    end
  end
  return nil
end

require("cmp").register_source("jira", source.new())

return cmp_jira
