local config = require('config')

-- App shortcuts
local bindApp = function(appName)
  return function()
    hs.application.launchOrFocus(appName)
  end
end

hs.hotkey.bind(config.hyper, 'c', bindApp('kitty'))
hs.hotkey.bind(config.hyper, 'g', bindApp('Whatsapp'))
hs.hotkey.bind(config.hyper, 'e', bindApp('Discord'))
hs.hotkey.bind(config.hyper, 'r', bindApp('Notion'))
hs.hotkey.bind(config.hyper, 'f', bindApp('Google Chrome'))
hs.hotkey.bind(config.hyper, 'v', bindApp('Spotify'))
hs.hotkey.bind(config.hyper, 't', bindApp('Tomito'))

-- Spotify shorcuts
hs.hotkey.bind(config.hyper, '\\', hs.spotify.playpause)
hs.hotkey.bind(config.hyper, '[',  hs.spotify.previous)
hs.hotkey.bind(config.hyper, ']',  hs.spotify.next)

-- Reload shortcut
hs.hotkey.bind(config.hyperCmd, 'r', hs.reload)

hs.alert.show('Config loaded')
