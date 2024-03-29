-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- https://wezfurlong.org/wezterm/#features

-- TODO: monitor this one https://github.com/wez/wezterm/issues/549
-- which will allow draging around tabs, the one feature that I think is missing
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local function get_system_appearance()
  local appearance = 'Dark'

  if (wezterm.gui) then
    appearance = wezterm.gui.get_appearance()
  end
  return appearance
end


local function color_scheme_for_system_theme()
  if get_system_appearance():find 'Dark' then
    return 'OneDark (base16)'
  else
    return 'One Light (base16)'
  end
end

-- This is where you actually apply your config choices

local font_size = 15
local font = wezterm.font_with_fallback({
  {
    -- Normal text
    --weight = 'Bold',
    --family = 'CommitMono Nerd Font Propo',
    family = '0xProto Nerd Font Propo',
    --family = 'MonaspiceNe Nerd Font',
    --family = 'Inconsolata Nerd Font',
    --harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' }
    harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' }
  },
  'JetBrains Mono'
})

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.use_fancy_tab_bar = true

config.font = font
config.font_size = font_size
config.color_scheme = color_scheme_for_system_theme()

--config.colors = {
--  cursor_bg = 'orange',
--  cursor_fg = 'orange',
--  cursor_border = 'orange'
--}

config.scrollback_lines = 100000
--config.enable_scroll_bar = true

config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = font,

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = font_size - 2
}
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
}
config.window_padding = {
  left = '0.25cell',
  right = '0.25cell',
  top = '0.25cell',
  bottom = '0.25cell',
}

config.keys = {
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action { SendString = "\x1bOH" },
  },
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action { SendString = "\x1bOF" },
  },
}

-- and finally, return the configuration to wezterm
return config
