return {
	"tpope/vim-fugitive",
	-- "vhyrro/luarocks.nvim",
	"xiyaowong/transparent.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
	-- {
	-- 	"nvim-lua/plenary.nvim",
	-- 	name = "plenary",
	-- },
	-- { "gleam-lang/gleam.vim" },
	{ "numToStr/Comment.nvim", opts = {}, lazy = false },
	{ "m4xshen/autoclose.nvim", config = true },
	{
		"lewis6991/gitsigns.nvim",
		config = true,
		opts = {
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 200,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
		},
	},
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		keys = {
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
			},
		},
	},
}
