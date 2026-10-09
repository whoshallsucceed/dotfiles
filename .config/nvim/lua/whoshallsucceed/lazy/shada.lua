-- After experiencing multiple times issues with this error:
--   E138: All /home/bart/.local/state/nvim/shada/main.shada.tmp.X files exist,
--   cannot write ShaDa file!
-- which is due to the fact that there are nvim session being killed when I
-- power off, we are now removing temp files that are empty and older than 60
-- seconds. A write in progress from another running instance is always younger
-- than that, so it's safe. Since each new Neovim start does this, the 26 slots
-- never fill up.

local shada_dir = vim.fn.stdpath('state') .. '/shada'
for _, f in ipairs(vim.fn.glob(shada_dir .. '/main.shada.tmp.*', false, true)) do
  local stat = (vim.uv or vim.loop).fs_stat(f)
  if stat and stat.size == 0 and (os.time() - stat.mtime.sec) > 60 then
    (vim.uv or vim.loop).fs_unlink(f)
  end
end

-- By default ShaDa is only written on exit, so a power-off loses everything
-- from the session. This writes it when the window loses focus:
vim.api.nvim_create_autocmd('FocusLost', { command = 'silent! wshada' })

return {}
