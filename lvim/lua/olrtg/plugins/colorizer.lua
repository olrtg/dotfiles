local M = {}

M.config = function()
	local status_ok, colorizer = pcall(require, "colorizer")

	if not status_ok then
		return
	end

	-- https://github.com/norcalli/nvim-colorizer.lua#customization
	local files = { "*" }
	local options = {
		RGB = true,
		RRGGBB = true,
		RRGGBBAA = true,
		rgb_fn = true,
		hsl_fn = true,
		css = true,
		css_fn = true,
	}

	colorizer.config(files, options)
end

return M
