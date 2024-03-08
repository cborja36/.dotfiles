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
	use("nvim-treesitter/nvim-treesitter-context")

	use("tpope/vim-commentary") -- comment out code
	use("tpope/vim-fugitive") -- git integration
	-- use("tpope/vim-vinegar") -- file explorer (extraño bug al reenfocar la ventana)
	use("tpope/vim-surround") -- surround text with characters
	use("stevearc/oil.nvim") -- file explorer

	use("NVChad/nvim-colorizer.lua")
	use("ggandor/leap.nvim")

	use("rose-pine/neovim")
	use("nvim-lualine/lualine.nvim")
	use({ "alvarosevilla95/luatab.nvim", requires = "kyazdani42/nvim-web-devicons" })
	-- use("j-hui/fidget.nvim")
	use("folke/zen-mode.nvim")
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	})
	use("sindrets/diffview.nvim")

	-- use({
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	config = function()
	-- 		require("ibl").setup({
	-- 			indent = {
	-- 				char = "▏",
	-- 			},
	-- 		})
	-- 	end,
	-- })

	use({
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_key_mappings = { headers = 0 }
		end,
	})

	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("lewis6991/gitsigns.nvim")
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	})

	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		tag = "*",
	})

	-- use("github/copilot.vim")
	use({ "cjrh/vim-conda", opt = true, cmd = { "CondaChangeEnv" } })
	use("eandrju/cellular-automaton.nvim") -- Easter egg
	use("lervag/vimtex")
	use("knubie/vim-kitty-navigator")

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
			vim.g.slime_target = "kitty"
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
