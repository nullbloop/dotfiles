 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#181429',
    base01 = '#282244',
    base02 = '#241f3d',
    base03 = '#656271',
    base04 = '#b0afb6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#cc66b9',
    base0A = '#b05cd6',
    base0B = '#7f67e4',
    base0C = '#e996d9',
    base0D = '#a493ec',
    base0E = '#cf96e9',
    base0F = '#e3bef4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#181429' })
  hi('TelescopeBorder',         { fg = '#656271',             bg = '#181429' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#181429' })
  hi('TelescopePromptBorder',   { fg = '#656271',             bg = '#181429' })
  hi('TelescopePromptPrefix',   { fg = '#7f67e4',             bg = '#181429' })
  hi('TelescopePromptCounter',  { fg = '#b0afb6',  bg = '#181429' })
  hi('TelescopePromptTitle',    { fg = '#181429',             bg = '#7f67e4' })
  hi('TelescopePreviewTitle',   { fg = '#181429',             bg = '#b05cd6' })
  hi('TelescopeResultsTitle',   { fg = '#181429',             bg = '#cc66b9' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#241f3d' })
  hi('TelescopeSelectionCaret', { fg = '#7f67e4',             bg = '#241f3d' })
  hi('TelescopeMatching',       { fg = '#7f67e4',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#181429' })
  hi('MiniPickBorder',         { fg = '#656271',             bg = '#181429' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#181429' })
  hi('MiniPickPromptPrefix',   { fg = '#7f67e4',             bg = '#181429' })
  hi('MiniPickBorderText',    { fg = '#181429',             bg = '#7f67e4' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#241f3d' })
  hi('MiniPickPromptCaret', { fg = '#7f67e4',             bg = '#241f3d' })
  hi('MiniPickMatchRanges',       { fg = '#7f67e4',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
