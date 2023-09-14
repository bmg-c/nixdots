-- Hybrid line number --
vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a"

-- Search --
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false

-- Tabs, Spaces, Line wrapping etc. --
vim.o.wrap = true
vim.o.cursorline = true
vim.o.breakindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true -- Tab as spaces

-- Files --
vim.o.autoread = true

-- Scroll --
vim.o.scrolloff = 9

-- Keybinds --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clipboard --
-- vim.o.clipboard = 'unnamedplus'

-- nvim-tree --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
