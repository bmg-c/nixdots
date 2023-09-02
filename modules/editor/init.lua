vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.wrap = true
vim.o.cursorline = true
vim.o.breakindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoread = true
vim.o.scrolloff = 9
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------------------

local function map(m, k, v)
	vim.keymap.set(m, k, v, {})
end

----------
-- Base --
----------

map("n", "<leader>j", ":nohlsearch<CR>") -- Clear search

-- Do not copy to clipboard on 'x' press --
-- map("n", "x", '"_x')
-- map("n", "x", '"_X')
-- map("n", "<Del>", '"_x')

-- Paste and Copy to system clipboard --
map("v", '<leader>y', '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", '<leader>y', '"+y')
map("n", '<leader>yy', '"+yy')

map("n", "<leader>p", '"+p')
map("n", "<leader>p", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>p", '"+P')

-------------------------
-- Plugins Keybindings --
-------------------------

-- nvim-tree --
map("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")

--------------------------------------------------------------------------------

vim.cmd("colorscheme catppuccin-mocha")

require("lualine").setup({
    icons_enabled = true,
    theme = "catppuccin",
})

require("nvim-tree").setup()
--require('nvim-treesitter.configs').setup {
--    ensure_installed = { 'vim', 'vimdoc', 'lua', 'cpp' },
--    auto_install = true,
--    highlight = { enable = true },
--    indent = { enable = true },
--}

require('Comment').setup()

vim.cmd([[set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,V>,Z?]])

