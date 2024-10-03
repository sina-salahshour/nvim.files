return {

	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.files").setup()
		vim.keymap.set("n", "<leader>E", MiniFiles.open, { desc = "Open file explorer" })
		vim.keymap.set("n", "<leader>e", function()
			MiniFiles.open(vim.api.nvim_buf_get_name(0))
		end, { desc = "Open file explorer" })
	end,
}
