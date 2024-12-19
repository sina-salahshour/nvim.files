vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.pz", -- Replace with your custom file extension
	callback = function()
		vim.cmd("set filetype=piaz")

		vim.o.commentstring = "# %s"
	end,
})

require("lux.config")
require("lux.init_lazy")
require("lux.init_after")
require("lux.registers")
