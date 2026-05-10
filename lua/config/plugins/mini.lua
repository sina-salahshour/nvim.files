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
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				local win_id = args.data.win_id

				local config = vim.api.nvim_win_get_config(win_id)
				config.border, config.title_pos = "rounded", "left"
				vim.api.nvim_win_set_config(win_id, config)
			end,
		})
	end,
}
