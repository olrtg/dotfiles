local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

if wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
	config.font_size = 14.0
else
	config.font_size = 12.0
end

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.line_height = 1.1
config.warn_about_missing_glyphs = false
config.hide_tab_bar_if_only_one_tab = true

return config