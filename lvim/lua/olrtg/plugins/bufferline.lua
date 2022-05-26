local M = {}

M.config = function()
	if not lvim.builtin.bufferline.active then
		return
	end

	lvim.builtin.bufferline.options = {
		indicator_icon = " ",
		show_buffer_close_icons = true,
		show_close_icon = false,
		offsets = {
			{ filetype = "NvimTree" },
		},
	}

	lvim.builtin.bufferline.highlights = {
		background = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
			guifg = { attribute = "fg", highlight = "LineNr" },
		},
		fill = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
			guifg = { attribute = "fg", highlight = "EndOfBuffer" },
		},
		separator = {
			guifg = { attribute = "fg", highlight = "EndOfBuffer" },
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
		},
		close_button = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
			guifg = { attribute = "fg", highlight = "LineNr" },
		},
		close_button_visible = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
			guifg = { attribute = "fg", highlight = "LineNr" },
		},
		close_button_selected = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
			guifg = { attribute = "fg", highlight = "LineNr" },
		},
		buffer_visible = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
			guifg = { attribute = "fg", highlight = "LineNr" },
		},
		modified = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
		},
		modified_visible = {
			guibg = { attribute = "bg", highlight = "EndOfBuffer" },
		},
	}
end

return M
