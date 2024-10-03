return {
	"preservim/vim-markdown",
	config = function()
		vim.g.vim_markdown_folding_disabled = 1
		vim.g.vim_markdown_conceal = 3
		vim.g.vim_markdown_borderless_table = 1
		vim.opt.conceallevel = 3
	end,
	dependencies = {
		"godlygeek/tabular",
	},
}
