local wezterm = require 'wezterm'

local resurrect = wezterm.plugin.require 'https://github.com/MLFlexer/resurrect.wezterm'

resurrect.state_manager.change_state_save_dir(wezterm.home_dir .. '/.wezterm-resurrect-states')

resurrect.state_manager.set_encryption({
   enable = true,
   method = "rage",
   private_key = wezterm.home_dir .. '/.keys/age',
   public_key = "age140sjjdk934v5ly9r3g238zate8r9kjkdrgvz6gtm33e2g3mlh9tq93qfe7",
})

resurrect.state_manager.set_max_nlines(10000)

resurrect.state_manager.periodic_save({
   interval_seconds = 900,
})

wezterm.on('gui-startup', resurrect.state_manager.resurrect_on_gui_startup)

return {}