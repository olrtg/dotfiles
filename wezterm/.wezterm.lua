local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("Berkeley Mono")
config.font_size = 13.0
config.line_height = 1.2
config.warn_about_missing_glyphs = false
config.hide_tab_bar_if_only_one_tab = true

return config
