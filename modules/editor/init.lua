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
vim.g.mapleader = " "
vim.g.maplocalleader = " "
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
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>y", '"+y')
map("n", "<leader>yy", '"+yy')

map("n", "<leader>p", '"+p')
map("n", "<leader>p", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>p", '"+P')

-------------------------
-- Plugins Keybindings --
-------------------------

map("n", "<C-n>", ":NvimTreeFindFileToggle<CR>") -- nvim-tree
map("n", "<leader>f", ":Format<CR>")

--------------------------------------------------------------------------------

vim.cmd("colorscheme catppuccin-mocha")
require("lualine").setup({
	icons_enabled = true,
	theme = "catppuccin",
})
require("nvim-tree").setup()
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})
require("Comment").setup()
require("telescope").setup()
require("noice").setup()

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end
	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("<leader>a", vim.lsp.buf.code_action)
	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)
	bufmap("gr", require("telescope.builtin").lsp_references)
	bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
	bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)
	bufmap("K", vim.lsp.buf.hover)
end
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	Lua = {
		workspace = { checkThirdParty = false },
		telemetry = { enable = false },
	},
})
require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

local util = require("formatter.util")
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		sh = {
			function()
				return {
					exe = "shfmt",
					args = { "-i", 4, "-ci", "-bn" },
					stdin = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "clang-format",
					args = {
						"-assume-filename",
						util.escape_path(util.get_current_buffer_file_name()),
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		python = {
			require("formatter.filetypes.python").yapf,
		},
		c = {
			function()
				return {
					exe = "clang-format",
					args = {
						"-assume-filename",
						util.escape_path(util.get_current_buffer_file_name()),
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		nix = {
			require("formatter.filetypes.nix").alejandra,
		},
	},
})

vim.cmd(
	[[set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,V>,Z?]]
)
