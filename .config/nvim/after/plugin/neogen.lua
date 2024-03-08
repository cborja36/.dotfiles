local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>nf", ":lua require('neogen').generate({type = 'func'})<CR>", opts)

require('neogen').setup({ snippet_engine = "luasnip" })
