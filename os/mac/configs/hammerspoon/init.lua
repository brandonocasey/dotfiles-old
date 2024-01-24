-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, 'F17')

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
function enterHyperMode()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
function exitHyperMode()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

hyper:bind({}, 'left', function()
  hs.eventtap.keyStroke({ 'cmd', 'ctrl', 'option', 'shift' }, 'left')
  hyper.triggered = true
end)

hyper:bind({}, "l", function()
  hs.caffeinate.startScreensaver()
  hyper.triggered = true
end)

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)

local function reload_config()
  hs.reload()
end

hyper:bind({}, "r", function()
  reload_config()
  hyper.triggered = true
end)

hs.pathwatcher.new(os.getenv("XDG_CONFIG_HOME") .. "/hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")
