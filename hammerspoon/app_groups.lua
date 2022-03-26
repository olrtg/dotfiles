local config = require("config")

-- So in order to launch and close a group of apps we need the following:
-- 1. Keep track of the groups that are opened, even when hammerspoon is closed or the config has been reloaded.
-- 2. Know how to close apps even if thei're not opened.
-- 3. The keybinds should act as togglers (open if closed and viceversa).

local groups = {
	common = { "Discord", "Spotify" },
	work = { "kitty", "Whatsapp", "Notion", "Google Chrome", "Tomito" },
	lol = { "League of Legends", "Blitz" },
}

local bindGroup = function(group)
	return function()
		for _, app in pairs(group) do
			if app == "League of Legends" then
				hs.application.launchOrFocusByBundleID("com.riotgames.leagueoflegends")
			else
				hs.application.launchOrFocus(app)
			end
		end
	end
end

-- local closeWorkApps = function ()
--   for _, app in pairs(groups.work) do
--     hs.application.
--   end
-- end

hs.hotkey.bind(config.hyper, "1", bindGroup(groups.common))
hs.hotkey.bind(config.hyper, "2", bindGroup(groups.work))
hs.hotkey.bind(config.hyper, "3", bindGroup(groups.lol))
-- hs.hotkey.bind(config.hyper, "0", closeWorkApps())
