-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("tpope/vim-commentary") -- comment out code
	use("tpope/vim-fugitive") -- git integration
	-- use("tpope/vim-vinegar") -- file explorer (extraño bug al reenfocar la ventana)
	use("tpope/vim-surround") -- surround text with characters

	use("rose-pine/neovim")
	use("nvim-lualine/lualine.nvim")
	use("j-hui/fidget.nvim")

	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("lewis6991/gitsigns.nvim")
	use("rcarriga/nvim-notify")

	use("github/copilot.vim")
	use({ "cjrh/vim-conda", opt = true, cmd = { "CondaChangeEnv" } })
	use("eandrju/cellular-automaton.nvim") -- Easter egg
	use("lervag/vimtex")

	-- LSP Support
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")

	-- Snippets
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	use("mechatroner/rainbow_csv")

	-- Send code to REPL
	use("jpalardy/vim-slime")
	use({
		"klafyvel/vim-slime-cells",
		requires = { { "jpalardy/vim-slime", opt = true } },
		ft = { "julia", "python" },
		config = function()
			vim.g.slime_target = "neovim"
			vim.g.slime_cell_delimiter = "^\\s*##"
			vim.g.slime_bracketed_paste = 1
			vim.g.slime_no_mappings = 1
			vim.cmd([[
    nmap <leader>cv <Plug>SlimeConfig
    nmap <leader>cn <Plug>SlimeCellsSendAndGoToNext
    nmap <leader>cc <Plug>SlimeCellsSend
    nmap <leader>cj <Plug>SlimeCellsNext
    nmap <leader>ck <Plug>SlimeCellsPrev
    ]])
		end,
	})
end)
