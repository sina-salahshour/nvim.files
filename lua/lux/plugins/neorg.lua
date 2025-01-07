---@diagnostic disable: missing-fields, missing-parameter
return {
	"nvim-neorg/neorg",
	dependencies = { { "max397574/neorg-contexts" } },
	lazy = false,
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {
					config = {
						icons = {
							code_block = {
								conceal = true,
							},
						},
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/Documents/neorg/",
						},
						default_workspace = "notes",
					},
				},
				["core.presenter"] = {
					config = {
						zen_mode = "zen-mode",
					},
				},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.integrations.treesitter"] = {},
				["core.integrations.nvim-cmp"] = {},
				["core.integrations.image"] = {},
				["core.latex.renderer"] = {},
				["core.ui"] = {},
				["core.queries.native"] = {},
				["external.context"] = {},
			},
		})

		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,
}
