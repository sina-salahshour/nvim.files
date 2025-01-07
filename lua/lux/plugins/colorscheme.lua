return {
	{
		"andrew-george/telescope-themes",
		config = function()
			require("telescope").load_extension("themes")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		-- init = function()
		-- 	vim.cmd([[colorscheme catppuccin-mocha]])
		-- end,
		-- enabled = false,
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = true, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors) -- add/modify highlights
				return {}
			end,
			theme = "dragon", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "dragon", -- try "dragon" !
				light = "lotus",
			},
		},
		-- init = function()
		-- 	vim.cmd([[colorscheme kanagawa]])
		-- end,
		-- enabled = false,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},
		-- init = function()
		-- 	vim.o.background = "dark"
		-- 	vim.cmd([[colorscheme gruvbox]])
		-- end,
		-- enabled = false,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon",
			transparent = false,
			terminal_colors = true,
			styles = {
				sidebars = "transparent", -- style for sidebars, see below
				floats = "transparent",
			},
		},
		-- init = function()
		-- 	vim.o.background = "dark"
		-- 	vim.cmd([[colorscheme tokyonight]])
		-- end,
		-- enabled = false,
	},
	{
		"miikanissi/modus-themes.nvim",
		priority = 1000,

		-- init = function()
		-- 	vim.o.background = "dark"
		-- 	vim.cmd([[colorscheme modus]])
		-- end,
	},
	{
		"0xstepit/flow.nvim",
		lazy = false,
		priority = 1000,
		tag = "v1.0.0",
		opts = {
			theme = {
				style = "dark", --  "dark" | "light"
				contrast = "default", -- "default" | "high"
				transparent = false, -- true | false
			},
			colors = {
				mode = "default", -- "default" | "dark" | "light"
				fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
			},
			ui = {
				borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
				aggressive_spell = false, -- true | false
			},
		},
		config = true,
		-- init = function()
		-- 	vim.cmd([[colorscheme flow]])
		-- end,
		-- enabled = false,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		-- config = function()
		-- 	require("nordic").load()
		-- end,
		-- enabled = true,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		-- config = function()
		-- 	vim.o.background = "dark"
		-- 	vim.cmd([[colorscheme oxocarbon]])
		-- end,
		-- enabled = false,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
