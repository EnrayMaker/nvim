vim.g.mapleader = " "

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree left focus<CR>')
vim.keymap.set('n', '<leader>o', ':Neotree left git_status<CR>')

-- Helm и K8s от kube-utils
vim.keymap.set('n', '<leader>kht', '<cmd>HelmTemplateFromBuffer<CR>', { desc = 'Helm Template from Buffer' })
vim.keymap.set('n', '<leader>khd', '<cmd>HelmDryRunFromBuffer<CR>', { desc = 'Helm Dry Run from Buffer' })
vim.keymap.set('n', '<leader>khD', '<cmd>HelmDeployFromBuffer<CR>', { desc = 'Helm Deploy from Buffer' })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<Tab>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {noremap = true, silent = true})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {noremap = true, silent = true})

-- leap
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward-to)', { desc = 'Leap forward to' })
vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward-to)', { desc = 'Leap backward to' })
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)', { desc = 'Leap from window' })
