--- @param node TSNode|nil
--- @param parent_type string
local function find_nearest_parent(node, parent_type)
	while node do
		if node:type() == parent_type then
			return node
		end
		node = node:parent()
	end
end

vim.api.nvim_create_user_command("CopyJsonPath", function()
	if vim.bo.filetype ~= "json" and vim.bo.filetype ~= "jsonc" then
		vim.notify("Not a json file", vim.log.levels.ERROR, { title = "copy-json-path" })
		return
	end

	local keys = {}

	local node = vim.treesitter.get_node()
	assert(node, "No node found")

	local parent = node:parent()
	assert(parent, "No parent found")

	if parent:type() == "pair" then
		vim.print(parent:field("key"))
		local node_text = vim.treesitter.get_node_text(node, 0)
		table.insert(keys, node_text)
	end

	vim.print(keys)
end, {})
