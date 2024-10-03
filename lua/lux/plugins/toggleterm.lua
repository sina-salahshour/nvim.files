return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		local term = require("toggleterm");
		term.setup();
		vim.keymap.set("n", "<leader>j", term.toggle, { desc = "Toggle Integrated Terminal" })
	end
}
