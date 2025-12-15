vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Сохранить файл" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Закрыть окно" })

-- NeoTree
vim.keymap.set("n", "<leader>e", ":Neotree left focus<CR>")
vim.keymap.set("n", "<leader>o", ":Neotree left git_status<CR>")

-- Helm и K8s от kube-utils
vim.keymap.set("n", "<leader>kht", "<cmd>HelmTemplateFromBuffer<CR>", { desc = "Helm Template from Buffer" })
vim.keymap.set("n", "<leader>khd", "<cmd>HelmDryRunFromBuffer<CR>", { desc = "Helm Dry Run from Buffer" })
vim.keymap.set("n", "<leader>khD", "<cmd>HelmDeployFromBuffer<CR>", { desc = "Helm Deploy from Buffer" })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set('n', '<Tab>', builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { noremap = true, silent = true })

-- leap
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "Leap forward to" })
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "Leap backward to" })
vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap from window" })
vim.keymap.set("n", "X", "<Plug>(leap-backward-till)", { desc = "leap-backward-till" })
vim.keymap.set("n", "x", "<Plug>(leap-forward-till)", { desc = "leap-forward-till" })

local conform = require("conform")
-- Маппинг для форматирования всего файла (Normal mode)
vim.keymap.set({ "n" }, "<leader>fm", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format file (Conform)" })

-- Маппинг для форматирования выделения (Visual mode)
vim.keymap.set({ "x" }, "<leader>fm", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format selection (Conform)" })

-- В lua/core/*, где у вас vim.keymap.set(...)
local gs = require("gitsigns")

-- Gitsigns Mappings
vim.keymap.set("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		gs.next_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Next Hunk" })

vim.keymap.set("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		gs.prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Prev Hunk" })

-- Команды для работы с текущим изменением (Hunk)
vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })

-- Ключевой маппинг: Показать разницу/изменения
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk (Pop-up)" })
vim.keymap.set("n", "<leader>hb", function()
	gs.blame_line({ full = true })
end, { desc = "Blame Line" })
--vim.keymap.set("n", "<leader>ri", vim.lsp.buf.implementation, { desc = "LSP Implementations" })
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })

vim.keymap.set("n", "\\c", function()
	require("dap").continue()
end, { desc = "Continue/Start Debugging" })
vim.keymap.set("n", "\\o", function()
	require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "\\i", function()
	require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "\\u", function()
	require("dap").step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "\\b", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "\\B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "\\r", function()
	require("dap").repl.open()
end, { desc = "Open REPL" })
vim.keymap.set("n", "\\l", function()
	require("dap").run_last()
end, { desc = "Run Last" })
vim.keymap.set("n", "\\x", function()
	require("dap").terminate()
end, { desc = "Terminate Debugging" })
vim.keymap.set("n", "\\h", function()
	require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
vim.keymap.set({ "n", "v" }, "\\e", function()
	require("dapui").eval()
end, { desc = "Eval Expression" })

-- (+) Python-specific
vim.keymap.set("n", "<leader>lv", "<cmd>VenvSelect<cr>", { desc = "Select Virtual Env" })
-- Эти маппинги будут установлены с buffer = true через автокоманду в config.lua
vim.keymap.set("n", "<leader>dm", "<cmd>lua require('dap-python').test_method()<cr>", { desc = "Test Method" })
vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap-python').test_class()<cr>", { desc = "Test Class" })
