-- import gitsigns plugin safely
local setup, fidget = pcall(require, "fidget")
if not setup then
	return
end

-- configure/enable gitsigns
fidget.setup()
