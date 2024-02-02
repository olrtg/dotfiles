local utils = {}

--- @param dependency string
function utils.is_dependency_in_package_json(dependency)
  if vim.fn.filereadable(vim.fn.getcwd() .. "/package.json") ~= 0 then
    local package_json = vim.fn.json_decode(vim.fn.readfile("package.json"))
    if package_json[dependency] ~= nil then
      return true
    end

    local dev_dependencies = package_json["devDependencies"]
    if dev_dependencies ~= nil and dev_dependencies[dependency] ~= nil then
      return true
    end

    local dependencies = package_json["dependencies"]
    if dependencies ~= nil and dependencies[dependency] ~= nil then
      return true
    end
  end

  return false
end

function utils.is_web_project()
  return (vim.fn.glob("package.json") ~= "" or vim.fn.glob("yarn.lock") ~= "" or vim.fn.glob("node_modules") ~= "")
end

return utils
