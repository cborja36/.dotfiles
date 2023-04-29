-- MONOKAI THEME
-- require("monokai-pro").setup({
-- 	transparent_background = true,
-- })
-- vim.cmd("colorscheme monokai-pro")

-- ROSE-PINE THEME
require("rose-pine").setup({
	disable_background = true,
})

function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
