return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"stevearc/conform.nvim",
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_fallback = true })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
		},
		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"clangd",
				"ts_ls",
				"eslint",
				"tailwindcss",
				"emmet_language_server",
				"svelte",
				"pyright",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
								},
								-- Do not send telemetry data containing a randomized but unique identifier
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,
			},
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
		})

		-- Autoformatting Setup
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
				html = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				["_"] = { "prettier" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				local eslint_client = vim.lsp.get_clients({
					name = "eslint",
				})
				if #eslint_client ~= 0 then
					vim.cmd("EslintFixAll")
				end
				require("conform").format({
					bufnr = args.buf,
					lsp_fallback = true,
					quiet = true,
				})
			end,
		})

		-- LSPLINES

		require("lsp_lines").setup()
		vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

		vim.keymap.set("", "<leader>l", function()
			local config = vim.diagnostic.config() or {}
			if config.virtual_text then
				vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
			else
				vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
			end
		end, { desc = "Toggle lsp_lines" })
		vim.keymap.set("n", "<leader>ce", function()
			vim.cmd("EslintFixAll")
		end, {})
	end,
	-- enabled = false
}
