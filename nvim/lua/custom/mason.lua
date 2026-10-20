require("mason").setup()

local registry = require("mason-registry")

for _, pkg_name in ipairs({ "stylua", "prettier" }) do
	local ok, pkg = pcall(registry.get_package, pkg_name)
	if ok and not pkg:is_installed() then
		pkg:install()
	end
end
