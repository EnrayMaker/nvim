local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		-- Основные
		{ "ggandor/leap.nvim", opts = {} }, -- Конфигурация Leap
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "main",
			build = ":TSUpdate",
			lazy = false,
			opts = {
				ensure_installed = { "lua", "python", "cpp", "yaml", "terraform", "dockerfile", "bash", "helm" },
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			},
		},
		{ "neovim/nvim-lspconfig" },

		-- NeoTree
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
			lazy = false,
			opts = {
				window = {
					position = "left",
					width = 30,
				},
				filesystem = {
					hijack_netrw = true,
					use_libuv_file_watch = true,
				},
				-- Diagnostics icons удалены отсюда, так как они относятся к LSP
			},
		},

		-- nvim-cmp (Перенос из plugins/cmp.lua)
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
			},
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "buffer" },
						{ name = "path" },
					}),
					mapping = cmp.mapping.preset.insert({
						["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),
				})
			end,
		},

		-- Telescope (Оставлен минимальным, маппинги в mappings.lua)
		{ "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },

		-- conform.nvim (Перенос из plugins/formatting.lua)
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					yaml = { "yamlfmt" },
					cpp = { "clang_format" },
					terraform = { "terraform_fmt" },
				},
				format_on_save = true,
			},
		},

		-- gitsigns.nvim (Частичный перенос из plugins/gitsigns.lua)
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged_enable = true,
				signcolumn = true, -- true
				numhl = false, -- false
				linehl = false,
				word_diff = false,
				watch_gitdir = { follow_files = true },
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
					use_focus = true,
				},
				current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			},
		},

		{
			"NeogitOrg/neogit",
			lazy = true,
			dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
			cmd = "Neogit",
			keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" } },
		},

		-- Темы
		{ "eldritch-theme/eldritch.nvim", lazy = false, priority = 1000, opts = {} },

		-- Добавления для языков и DevOps
		-- lsp-zero + Mason + Mason-LSPConfig (Консолидировано)
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v3.x",
			dependencies = {
				"williamboman/mason-lspconfig.nvim", -- Добавляем сюда как зависимость
				"williamboman/mason.nvim",
			},
			config = function()
				local lsp_zero = require("lsp-zero")

				lsp_zero.on_attach(function(client, bufnr)
					lsp_zero.default_keymaps({ buffer = bufnr })
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, { buffer = bufnr, desc = "Показать подсказку" })
				end)

				-- Конфигурация Mason
				require("mason").setup({
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				})

				-- Конфигурация Mason-LSPconfig (Перенос из plugins/lsp.lua)
				require("mason-lspconfig").setup({
					ensure_installed = {
						"pyright",
						"clangd",
						"yamlls",
						"ansiblels",
						"dockerls",
						"helm_ls",
						"stylua",
						"black",
						"isort",
					},
					handlers = {
						lsp_zero.default_setup,
						lua_ls = function()
							require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
						end,
					},
				})

				-- Глобальная конфигурация диагностических значков (Перенос из NeoTree/старого lsp.lua)
				vim.diagnostic.config({
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = "",
							[vim.diagnostic.severity.WARN] = "",
							[vim.diagnostic.severity.INFO] = "",
							[vim.diagnostic.severity.HINT] = "󰌵",
						},
					},
				})
			end,
		},

		{ "nvim-treesitter/nvim-treesitter-context" },
		{ "tpope/vim-fugitive" }, -- Доступ к гит командам
		{ "pearofducks/ansible-vim" },
		{ "hashivim/vim-terraform" },
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},
		{ "echasnovski/mini.nvim" },
		-- helm-ls.nvim уже настроен через mason-lspconfig, но оставим плагин для filetype detection
		{ "mrjosh/helm-ls", ft = "helm" },
		{ "qvalentin/helm-ls.nvim", ft = "helm" },

		-- kube-utils (Настройки Helm LS из plugins/helm.lua были удалены, так как они в lsp-zero)
		{
			"h4ckm1n-dev/kube-utils-nvim",
			dependencies = { "nvim-telescope/telescope.nvim" },
			lazy = true,
			-- opts = {} -- Добавьте сюда настройки, если понадобятся
		},
	},
	checker = { enabled = true },
})
