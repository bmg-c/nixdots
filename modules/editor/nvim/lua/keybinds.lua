local function map(m, k, v)
	vim.keymap.set(m, k, v, {})
end

----------
-- Base --
----------

-- Clear search --
map("n", "<leader>j", ":nohlsearch<CR>")

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

map("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")
