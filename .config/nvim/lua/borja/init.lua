require("borja.remap")
require("borja.set")

-- Define highlight groups
vim.cmd("highlight JinjaTemplate guifg=Green ctermfg=Green")
vim.cmd("highlight JinjaControl guifg=Red ctermfg=Red")

local function highlight_jinja_templates()
	local template_pattern = "{{.-}}"
	local control_pattern = "{%%.-%%}"

	-- Iterate over each line in the buffer
	for line_num = 0, vim.api.nvim_buf_line_count(0) - 1 do
		local line = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]

		-- Highlight Jinja templates
		local s, e = string.find(line, template_pattern)
		while s do
			vim.api.nvim_buf_add_highlight(0, -1, "JinjaTemplate", line_num, s - 1, e)
			s, e = string.find(line, template_pattern, e + 1)
		end

		-- Highlight Jinja control structures
		s, e = string.find(line, control_pattern)
		while s do
			vim.api.nvim_buf_add_highlight(0, -1, "JinjaControl", line_num, s - 1, e)
			s, e = string.find(line, control_pattern, e + 1)
		end
	end
end

vim.api.nvim_create_user_command("HighlightJinjaTemplates", highlight_jinja_templates, {})

-- Define an autocmd group for your custom commands
vim.api.nvim_create_augroup("HighlightJinjaInHtml", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "HighlightJinjaInHtml",
	pattern = "html",
	callback = function()
		highlight_jinja_templates()
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "HighlightJinjaInHtml",
	pattern = "*.html",
	callback = function()
		highlight_jinja_templates()
	end,
})
