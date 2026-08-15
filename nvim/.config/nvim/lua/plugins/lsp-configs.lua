return {
	-- Mason
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason + lspconfig bridge
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = {
				"lua_ls", "ts_ls", "eslint", "tailwindcss", "pylsp",
				"bashls", "yamlls", "gopls", "zls", "svelte",
				"dockerls", "docker_compose_language_service",
			},
		},
		config = function()
			require("mason-lspconfig").setup()
		end,
	},

	-- LSP Config mới (Neovim 0.11+)
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local on_attach = function(client, bufnr)
				local bufmap = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
				end

				bufmap("n", "K",  vim.lsp.buf.hover,          "Hover")
				bufmap("n", "gd", vim.lsp.buf.definition,     "Goto Definition")
				bufmap("n", "gD", vim.lsp.buf.declaration,    "Goto Declaration")
				bufmap("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
				bufmap("n", "gr", vim.lsp.buf.references,     "Goto References")
				bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
				bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

				bufmap("n", "<leader>fm", function()
					local filetype = vim.bo.filetype
					local map = {
						python = "function", javascript = "function",
						typescript = "function", java = "class",
						lua = "function",
						go = { "method", "struct", "interface" },
					}
					local symbols = map[filetype] or "function"
					require("fzf-lua").lsp_document_symbols({ symbols = symbols })
				end, "List Functions/Methods")
			end

			vim.lsp.config("*", {
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Config riêng
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("pylsp", {
				settings = { pylsp = { plugins = { pycodestyle = { enabled = true }, pyflakes = { enabled = true } } } },
			})

			-- Bật tất cả server
			local servers = {
				"lua_ls", "ts_ls", "eslint", "pylsp", "tailwindcss",
				"yamlls", "bashls", "gopls", "zls", "svelte",
				"dockerls", "docker_compose_language_service",
			}
			for _, s in ipairs(servers) do vim.lsp.enable(s) end

			-- .proto files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "proto",
				callback = function() vim.lsp.enable("bufls", { reuse_client = false }) end,
			})
		end,
	},
}
