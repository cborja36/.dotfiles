-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	keymap.set("n", "<leader>ac", function()
		vim.lsp.buf.code_action()
	end, opts)
	keymap.set("n", "<leader>rr", function()
		vim.lsp.buf.references()
	end, opts)
	keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = {

	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- configure python server
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		-- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure javascript server
lspconfig["tsserver"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure json server
lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure svelte server
lspconfig["svelte"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure svelte server
lspconfig["rust_analyzer"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwind server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure c server
lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})


vim.diagnostic.config({virtual_text = false})
vim.api.nvim_create_user_command(
  'DiagnosticsToggleVirtualText',
  function()
    local current_value = vim.diagnostic.config().virtual_text
    if current_value then
      vim.diagnostic.config({virtual_text = false})
    else
      vim.diagnostic.config({virtual_text = true})
    end
  end,
  {}
)
vim.keymap.set("n", "<leader>tt", "<cmd>DiagnosticsToggleVirtualText<cr>")

vim.api.nvim_create_user_command(
  'DiagnosticsToggle',
  function()
    local current_value = vim.diagnostic.is_disabled()
    if current_value then
      vim.diagnostic.enable()
    else
      vim.diagnostic.disable()
    end
  end,
  {}
)
vim.keymap.set("n", "<leader>td", "<cmd>DiagnosticsToggle<cr>")
