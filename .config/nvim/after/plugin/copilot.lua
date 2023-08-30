-- vim.g.copilot_filetypes = {
-- 	["*"] = false,
-- 	["javascript"] = true,
-- 	["typescript"] = true,
-- 	["lua"] = true,
-- 	["rust"] = true,
-- 	["c"] = true,
-- 	["c#"] = true,
-- 	["c++"] = true,
-- 	["go"] = true,
-- 	["python"] = true,
-- 	["json"] = true,
-- 	["html"] = true,
-- 	["svelte"] = true,
-- }
-- vim.api.nvim_set_keymap("i", "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- vim.g.copilot_no_tab_map = true

-- vim.notify = require("notify")
-- local copilot_on = false
-- vim.api.nvim_create_user_command("CopilotToggle", function()
-- 	if copilot_on then
-- 		vim.cmd("Copilot disable")
-- 		vim.notify("Copilot OFF", "info", { render = "minimal" })
-- 	else
-- 		vim.cmd("Copilot enable")
-- 		vim.notify("Copilot ON", "info", { render = "minimal" })
-- 	end
-- 	copilot_on = not copilot_on
-- end, { nargs = 0 })
-- vim.keymap.set("n", "<C-j>", ":CopilotToggle<CR>")
-- vim.keymap.set("i", "<C-j>", "<ESC>:CopilotToggle<CR>a")





-- Esto no sirve pq se queda el ghost text en modo insertar
-- vim.keymap.set({ "n", "i" }, "<C-j>", vim.cmd.CopilotToggle)
