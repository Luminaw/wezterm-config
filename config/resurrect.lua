local wezterm = require('wezterm')

local resurrect = wezterm.plugin.require('file:///' .. wezterm.config_dir:gsub('\\', '/'):gsub('\\', '/') .. '/plugins/resurrect.wezterm')

resurrect.state_manager.change_state_save_dir(wezterm.home_dir .. '/.wezterm-resurrect-states')

local pub_file = io.open(wezterm.home_dir .. '/.keys/wez-key.age.pub', 'r')
local public_key = pub_file:read('*a'):gsub('[ \t\r\n]+', '')
pub_file:close()

resurrect.state_manager.set_encryption({
    enable = true,
    method = 'rage',
    private_key = wezterm.home_dir .. '/.keys/wez-key.age',
    public_key = public_key,
})
resurrect.state_manager.set_max_nlines(10000)

resurrect.state_manager.periodic_save({
   interval_seconds = 900,
})

wezterm.on('gui-startup', resurrect.state_manager.resurrect_on_gui_startup)

-- -- loads the state whenever I create a new workspace
-- wezterm.on('smart_workspace_switcher.workspace_switcher.created', function(window, path, label)
--    local workspace_state = resurrect.workspace_state

--    workspace_state.restore_workspace(resurrect.state_manager.load_state(label, 'workspace'), {
--       window = window,
--       relative = true,
--       restore_text = true,
--       on_pane_restore = resurrect.tab_state.default_on_pane_restore,
--    })
-- end)

-- -- Saves the state whenever I select a workspace
-- wezterm.on('smart_workspace_switcher.workspace_switcher.selected', function(window, path, label)
--    local workspace_state = resurrect.workspace_state
--    resurrect.state_manager.save_state(workspace_state.get_workspace_state())
-- end)

return {}
