local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Shell
config.default_prog = { '/bin/zsh' }

-- Font
config.font = wezterm.font_with_fallback({
  { family = 'Source Code Pro', weight = 'Regular' },
  'JetBrains Mono',
  'Menlo',
})
config.font_size = 13.0
config.bold_brightens_ansi_colors = true

-- Dracula theme
config.colors = {
  foreground = '#f8f8f2',
  background = '#282a36',
  cursor_bg = '#f8f8f2',
  cursor_fg = '#282a36',
  cursor_border = '#f8f8f2',
  selection_fg = '#f8f8f2',
  selection_bg = '#44475a',
  ansi = {
    '#21222c', -- black
    '#ff5555', -- red
    '#50fa7b', -- green
    '#f1fa8c', -- yellow
    '#bd93f9', -- blue
    '#ff79c6', -- magenta
    '#8be9fd', -- cyan
    '#f8f8f2', -- white
  },
  brights = {
    '#6272a4', -- bright black
    '#ff6e6e', -- bright red
    '#69ff94', -- bright green
    '#ffffa5', -- bright yellow
    '#d6acff', -- bright blue
    '#ff92df', -- bright magenta
    '#a4ffff', -- bright cyan
    '#ffffff', -- bright white
  },
}

-- Window
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.scrollback_lines = 10000
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true

-- Cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500

-- Mouse
config.hide_mouse_cursor_when_typing = true

-- Raccourcis clavier (mêmes qu'Alacritty)
config.keys = {
  -- Ctrl+Tab / Ctrl+Shift+Tab → navigation tmux
  { key = 'Tab', mods = 'CTRL',       action = wezterm.action.SendString('\x1b[27;5;9~') },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.SendString('\x1b[27;6;9~') },
  -- Ctrl+Space → préfixe tmux
  { key = 'Space', mods = 'CTRL', action = wezterm.action.SendString('\x00') },
  -- Copier/coller
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  -- Passer Ctrl+E et Ctrl+O à tmux (splits)
  { key = 'e', mods = 'CTRL', action = wezterm.action.SendString('\x05') },
  { key = 'o', mods = 'CTRL', action = wezterm.action.SendString('\x0f') },
}

return config
