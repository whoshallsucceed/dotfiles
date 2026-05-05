vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- If the 'ignorecase' option is on, the case of normal letters is ignored.
-- 'smartcase' can be set to ignore case when the pattern contains lowercase
-- letters only.
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.showbreak = "↪ "
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", eol = "¬", trail = "⌴" }

vim.opt.gdefault = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Keep the current directory and the browsing directory synced. This helps avoid the move files error.
vim.g.netrw_keepdir = 0

-- Change the copy command. Mostly to enable recursive copy of directories.
vim.g.netrw_localcopydircmd = 'cp -r'

---- BEGIN The following stuff is to preserve original CWD while keeping `netrw_keepdir = 0`
-- Store the startup directory
local startup_dir = vim.fn.getcwd()

-- Restore it after opening files
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Only restore if we're not in a terminal buffer, help, or special filetypes
    local bt = vim.bo.buftype
    local ft = vim.bo.filetype
    if bt == "" and ft ~= "netrw" and ft ~= "help" then
      vim.cmd("cd " .. startup_dir)
    end
  end,
})
---- END

-- BEGIN ShaDa
-- Ignore files in /tmp and .git directories from ShaDa
-- This is an attempt in getting rid of this error:
--   E138: All /home/bart/.local/state/nvim/shada/main.shada.tmp.X files exist, cannot write ShaDa file!
vim.opt.shada:append({ "r/tmp/*", "r*.git*" })
