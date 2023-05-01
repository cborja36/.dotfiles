vim.g.python3_host_prog = "/Users/borjacastillo/miniforge3/envs/py3nvim/bin/python"
vim.g.netrw_dirhistmax = 0
vim.opt.history = 200
vim.opt.termguicolors = true

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.smartindent = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80"

vim.opt.hlsearch = true

if vim.fn.has("nvim") == 1 and vim.fn.executable("nvr") == 1 then
	vim.env.VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

if vim.fn.has("nvim") == 1 then
	vim.cmd("highlight! link TermCursor Cursor")
	vim.cmd("highlight! TermCursorNC guibg=orange guifg=white ctermbg=3 ctermfg=15")
end
