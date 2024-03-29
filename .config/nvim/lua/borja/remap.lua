local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.kitty_navigator_no_mappings = 1

keymap.set("n", "<s-left>", "<cmd>silent KittyNavigateLeft<cr>")
keymap.set("n", "<s-down>", "<cmd>silent KittyNavigateDown<cr>")
keymap.set("n", "<s-up>", "<cmd>silent KittyNavigateUp<cr>")
keymap.set("n", "<s-right>", "<cmd>silent KittyNavigateRight<cr>")

keymap.set("n", "<leader>l", vim.lsp.buf.format)
keymap.set(
	"n",
	"<leader>cd",
	[[<Cmd>let dir = (&ft !=# 'netrw') ? expand('%:p:h') : b:netrw_curdir | execute 'lcd '.dir | echo 'lcd '.dir<CR>]],
	{ silent = false }
)

keymap.set("n", "<leader>s", ":w<CR>")
keymap.set("n", "<leader>q", "<C-z>")
keymap.set("n", "<leader>Q", ":q!<CR>")

keymap.set("n", "<C-q>", "<cmd>lua vim.diagnostic.setqflist()<cr>")
keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>cq", "<cmd>cclose<cr>")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Fast endline semicolon
-- keymap.set("n", "AA", "A;<ESC>")

-- Better movement with j and k
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

-- Better vertical movement
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Manage tabs
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- register keymaps
keymap.set("x", "<leader>p", [["_dP]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- terminal
keymap.set("t", "<Esc>", "<C-\\><C-n>")
keymap.set("t", "<C-v><Esc>", "<Esc>")
keymap.set("t", "<s-left>", "<cmd>silent KittyNavigateLeft<cr>")
keymap.set("t", "<s-down>", "<cmd>silent KittyNavigateDown<cr>")
keymap.set("t", "<s-up>", "<cmd>silent KittyNavigateUp<cr>")
keymap.set("t", "<s-right>", "<cmd>silent KittyNavigateRight<cr>")

-- Easter egg
-- keymap.set("n", "<leader>zz", "<cmd>ZenMode<CR>")
keymap.set("n", "<leader>zz", "<cmd>CellularAutomaton make_it_rain<CR>")

local Path = require("plenary.path")
vim.api.nvim_create_user_command("RunScript", function()
	local run_script_path = Path:new("run.sh")
	if run_script_path:exists() then
		vim.cmd("terminal ./run.sh")
	else
		local filetype = vim.bo.filetype
		if filetype == "python" then
			vim.cmd("terminal python3 %")
		elseif filetype == "c" then
			-- Replace with your preferred C run command
			vim.cmd("terminal gcc % && ./a.out")
		elseif filetype == "rust" then
			vim.cmd("terminal cargo run")
		elseif filetype == "javascript" then
			-- Replace with your preferred Node.js run command
			vim.cmd("terminal node %")
		else
			print("Unsupported filetype for RunScript")
		end
	end
end, {})
vim.keymap.set("n", "<leader>x", "<cmd>RunScript<CR>")
