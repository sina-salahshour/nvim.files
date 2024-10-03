return {

	"ThemerCorp/themer.lua",

	config = true,
	init = function()
		require("themer").setup({
			colorscheme = "rose_pine",
			dim_inactive = true,
			styles = {
				["function"] = { style = "italic" },
				functionbuiltin = { style = "italic" },
				variable = { style = "italic" },
				variableBuiltIn = { style = "italic" },
				parameter = { style = "italic" },
			},
		})
		require("telescope").load_extension("themes")
	end,
	-- enabled = false,
}
