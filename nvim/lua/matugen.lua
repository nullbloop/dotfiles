 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#03243a',
    base01 = '#0f3b57',
    base02 = '#0b3550',
    base03 = '#636d73',
    base04 = '#afb3b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#8333ff',
    base0A = '#3349ff',
    base0B = '#4cb9ff',
    base0C = '#b280ff',
    base0D = '#80cdff',
    base0E = '#808dff',
    base0F = '#b3bbff',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#03243a' })
  hi('TelescopeBorder',         { fg = '#636d73',             bg = '#03243a' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#03243a' })
  hi('TelescopePromptBorder',   { fg = '#636d73',             bg = '#03243a' })
  hi('TelescopePromptPrefix',   { fg = '#4cb9ff',             bg = '#03243a' })
  hi('TelescopePromptCounter',  { fg = '#afb3b6',  bg = '#03243a' })
  hi('TelescopePromptTitle',    { fg = '#03243a',             bg = '#4cb9ff' })
  hi('TelescopePreviewTitle',   { fg = '#03243a',             bg = '#3349ff' })
  hi('TelescopeResultsTitle',   { fg = '#03243a',             bg = '#8333ff' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#0b3550' })
  hi('TelescopeSelectionCaret', { fg = '#4cb9ff',             bg = '#0b3550' })
  hi('TelescopeMatching',       { fg = '#4cb9ff',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#03243a' })
  hi('MiniPickBorder',         { fg = '#636d73',             bg = '#03243a' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#03243a' })
  hi('MiniPickPromptPrefix',   { fg = '#4cb9ff',             bg = '#03243a' })
  hi('MiniPickBorderText',    { fg = '#03243a',             bg = '#4cb9ff' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#0b3550' })
  hi('MiniPickPromptCaret', { fg = '#4cb9ff',             bg = '#0b3550' })
  hi('MiniPickMatchRanges',       { fg = '#4cb9ff',             bold = true })
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
