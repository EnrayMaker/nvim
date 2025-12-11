local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--if not (vim.uv or vim.loop).fs_stat(lazypath) then
--	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--	if vim.v.shell_error ~= 0 then
--		vim.api.nvim_echo({
--			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--			{ out, "WarningMsg" },
--			{ "\nPress any key to exit..." },
--		}, true, {})
--		vim.fn.getchar()
--		os.exit(1)
--	end
--end
vim.opt.rtp:prepend(lazypath)

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
				ensure_installed = { "lua", "python", "cpp", "yaml", "bash" },
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			},
		},
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
			},
		},

		-- nvim-cmp
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

		-- Telescope
		{ "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },

		-- conform.nvim
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

		-- gitsigns.nvim
		{
			"lewis6991/gitsigns.nvim",
			opts = {},
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
		-- lsp
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v3.x",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"williamboman/mason.nvim",
			},
			config = function()
				local lsp_zero = require("lsp-zero")

				lsp_zero.on_attach(function(client, bufnr)
					lsp_zero.default_keymaps({ buffer = bufnr })
				end)
				require("mason").setup()
				require("mason-lspconfig").setup({
					ensure_installed = {
						"pyright",
						"clangd",
						"yamlls",
						"ansiblels",
						"dockerls",
						"helm_ls",
					},
					handlers = {
						lsp_zero.default_setup,
					},
				})
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
		{ "tpope/vim-fugitive" }, -- Доступ к гит командам
		{ "pearofducks/ansible-vim" },
		{ "hashivim/vim-terraform" },
		{
			"folke/trouble.nvim",
			opts = {},
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
		{ "mrjosh/helm-ls", ft = "helm" },
		-- kube-utils
		{
			"h4ckm1n-dev/kube-utils-nvim",
			dependencies = { "nvim-telescope/telescope.nvim" },
			lazy = true,
		},
	},
	checker = { enabled = true },
})
