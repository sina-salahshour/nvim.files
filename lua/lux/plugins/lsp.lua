return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"jcha0713/cmp-tw2css",
		"SergioRibera/cmp-dotenv",
		"petertriho/cmp-git",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"onsails/lspkind.nvim",
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
		"mlaursen/vim-react-snippets",
	},
	config = function()
		require("vim-react-snippets").lazy_load()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		require("fidget").setup({})
		require("mason").setup()

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		require("mason").setup()
		require("mason-lspconfig").setup({
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

				["eslint"] = function()
					local lspconfig = require("lspconfig")

					lspconfig.eslint.setup({
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

		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_confirm = { behavior = cmp.ConfirmBehavior.Replace, select = true }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<c-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<c-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<c-y>"] = cmp.mapping.confirm(cmp_confirm),
				["<tab>"] = cmp.mapping.confirm(cmp_confirm),
				["<c-space>"] = cmp.mapping.complete(),
				["<c-f>"] = cmp.mapping.scroll_docs(4),
				["<c-d>"] = cmp.mapping.scroll_docs(-4),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "cmp-tw2css" },
				{ name = "dotenv" },
				{ name = "path" },
				{ name = "buffer" },
			}),
			experimental = {
				ghost_text = true,
				native_menu = false,
			},
			window = { -- This seems to override blend option
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				format = require("lspkind").cmp_format({
					before = require("tailwind-tools.cmp").lspkind_format,
					mode = "symbol", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- can also be a function to dynamically calculate max width such as
					-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
				}),
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

		conform.formatters.injected = {
			options = {
				ignore_errors = false,
				lang_to_formatters = {
					sql = { "sleek" },
				},
			},
		}

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

		-- luasnip jumps
		local keymap = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
		keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
		keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
		keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

		-- cmdline cmp
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- cmp git
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" },
			}, {
				{ name = "buffer" },
			}),
		})
		require("cmp_git").setup()

		-- autocmds

		vim.api.nvim_create_autocmd("LspAttach", {

			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
					border = "rounded",
					winblend = vim.o.winblend,
				})

				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- jump to the definition of the word under your cursor.
				--  this is where a variable was first declared, or where a function is defined, etc.
				--  to jump back, press <C-t>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- find references for the word under your cursor.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- jump to the implementation of the word under your cursor.
				--  useful when your language has ways of declaring types without an actual implementation.
				map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- jump to the type of the word under your cursor.
				--  useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("<leader>d", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- fuzzy find all the symbols in your current document.
				--  symbols are things like variables, functions, types, etc.
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- fuzzy find all the symbols in your current workspace.
				--  similar to document symbols, except searches over your entire project.
				map("<leader>qs", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- rename the variable under your cursor.
				--  most language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- opens a popup that displays documentation about the word under your cursor
				--  see `:help k` for why this keymap.
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				-- warn: this is not Goto Definition, this is Goto Declaration.
				--  for example, in C this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- the following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    see `:help CursorHold` for information about when this is executed
				--
				-- when you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})
	end,
}
