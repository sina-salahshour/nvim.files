return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"vimdoc",
				"javascript",
				"typescript",
				"c",
				"lua",
				"rust",
				"jsdoc",
				"bash",
			},

			sync_install = false,

			auto_install = true,

			indent = {
				enable = true,
			},

			highlight = {
				enable = true,

				additional_vim_regex_highlighting = { "markdown" },
			},
			ignore_install = {},
			modules = {},
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.mah = {
			install_info = {
				url = "/home/drhe/Documents/code/uni/compiler/mah/syntax-highlight",
				generate_requires_npm = false,
				requires_generate_from_grammar = false,
				files = { "src/parser.c" },
			},
			filetype = "mah",
		}

		vim.filetype.add({
			extension = {
				mh = "mah",
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "mah",
			callback = function()
				vim.bo.commentstring = "# %s"
			end,
		})
		vim.treesitter.language.register("mah", { "mh" })

		vim.treesitter.language.register("prolog", "pl")
	end,
}
