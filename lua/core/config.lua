vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"
vim.opt.showmode = false
vim.opt.updatetime = 100
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.wo.linebreak = true
vim.opt.virtualedit = "block"
vim.opt.undofile = true
vim.opt.shell = "/bin/zsh"

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Shorter messages
vim.opt.shortmess:append("c")

-- Indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Fillchars
vim.opt.fillchars = {
    vert = "│",
    fold = "⠀",
    eob = " ", -- suppress ~ at EndOfBuffer
    -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸"
}

-- ОТОБРАЖЕНИЕ
vim.opt.termguicolors = true    -- **КРИТИЧЕСКИ ВАЖНО:** Включает 24-битный цвет для тем (без этого многие темы не работают!)
vim.opt.cursorline = true       -- Выделяет строку, на которой находится курсор. (Очень помогает)
vim.opt.isfname:append("@-@")   -- Добавляет дефис (-) в список символов, которые считаются частью имени файла. (Полезно в программировании)
vim.opt.cmdheight = 1           -- Высота командной строки. (1 - компактнее)
vim.opt.laststatus = 3          -- Глобальная строка состояния (всегда внизу, даже при одном окне). (Нужно для Lualine/Statusline)
vim.opt.pumheight = 10          -- Высота окна всплывающего меню (для `nvim-cmp`).
vim.opt.autoread = true         -- Автоматически перезагружать файл, если он был изменен извне. (Полезно для Git и внешних программ)
vim.opt.timeoutlen = 500        -- Время в мс, в течение которого Neovim ждет продолжения маппинга (например, после нажатия `<leader>`).

-- ПОИСК
vim.opt.hlsearch = true         -- Подсвечивать все совпадения поиска.
vim.opt.incsearch = true        -- Подсвечивать совпадения по мере ввода.
vim.opt.ignorecase = true       -- Игнорировать регистр при поиске.
vim.opt.smartcase = true        -- Если в поиске есть заглавные буквы, поиск становится чувствительным к регистру. (Лучшая комбинация с ignorecase)

-- СВОП И БЭКАПЫ
--vim.opt.swapfile = false        -- Не создавать swap-файлы. (Современный Neovim с undo-файлами в них не нуждается)
--vim.opt.backup = false          -- Не создавать файлы бэкапа. (У нас есть Git!)

vim.cmd([[highlight clear LineNr]])
vim.cmd([[highlight clear SignColumn]])
-- vim.opt.cursorline = true
-- vim.opt.colorcolumn = "80"
