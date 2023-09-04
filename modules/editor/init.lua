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

vim.keymap.set("n", "<leader>j", ":nohlsearch<CR>", { silent = true }) -- Clear search

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

vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { silent = true }) -- nvim-tree
vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true }) -- formatter.nvim

-- trouble --
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").open()
end)
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").open("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").open("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").open("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").open("loclist")
end)
vim.keymap.set("n", "gR", function()
	require("trouble").open("lsp_references")
end)

vim.keymap.set("n", "m", function()
	require("harpoon.mark").add_file()
end)
vim.keymap.set("n", "<C-m>", function()
	require("harpoon.ui").toggle_quick_menu()
end)
vim.keymap.set("n", "n", function()
	require("harpoon.ui").nav_next()
end)
vim.keymap.set("n", "<C-1>", function()
	require("harpoon.ui").nav_file(1)
end)
vim.keymap.set("n", "<C-2>", function()
	require("harpoon.ui").nav_file(2)
end)
vim.keymap.set("n", "<C-3>", function()
	require("harpoon.ui").nav_file(3)
end)
vim.keymap.set("n", "<C-4>", function()
	require("harpoon.ui").nav_file(4)
end)

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
-- require("noice").setup()
require("nvim-autopairs").setup()
require("trouble").setup()
require("harpoon").setup()

vim.opt.list = true
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

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
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

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

local home = os.getenv("HOME")
local jdtls = require("jdtls")
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local config = {
	flags = {
		debounce_text_changes = 80,
	},
	on_attach = on_attach,
	root_dir = root_dir,
	settings = {
		java = {
			format = {
				settings = {
					-- Use Google Java style guidelines for formatting
					-- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
					-- and place it in the ~/.local/share/eclipse directory
					url = "/.local/share/eclipse/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
			-- Specify any completion options
		},
	},
	cmd = {
		"jdt-language-server",
		"-data",
		workspace_folder,
	},
}
jdtls.start_or_attach(config)

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
		java = {
			require("formatter.filetypes.java").clangformat,
		},
	},
})

-------------------------------------------------------------------------------
---------- Coc
-- vim.opt.backup = false
-- vim.opt.writebackup = false
-- vim.opt.signcolumn = "yes"
--
-- -- vim.opt.updatetime = 300 -- Still to test
--
-- --- Keymaps
--
-- local keyset = vim.keymap.set
-- -- Autocomplete
-- function _G.check_back_space()
--     local col = vim.fn.col('.') - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end
--
-- local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
-- keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
-- keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
--
-- -- Use <c-j> to trigger snippets
-- keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- -- Use <c-space> to trigger completion
-- keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
--
-- -- Use `[g` and `]g` to navigate diagnostics
-- -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
-- keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
-- keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
-- -- GoTo code navigation
-- keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
-- keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
-- keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
-- keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
-- -- Use K to show documentation in preview window
-- function _G.show_docs()
--     local cw = vim.fn.expand('<cword>')
--     if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
--         vim.api.nvim_command('h ' .. cw)
--     elseif vim.api.nvim_eval('coc#rpc#ready()') then
--         vim.fn.CocActionAsync('doHover')
--     else
--         vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
--     end
-- end
-- keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
--
-- -- Symbol renaming
-- keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
--
-- -- Formatting selected code
-- -- keyset("x", "<leader>f", "<Plug>(coc-format)", {silent = true})
-- keyset("n", "<leader>f", "<Plug>(coc-format)", {silent = true})
-------------------------------------------------------------------------------
--
vim.cmd(
	[[set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,V>,Z?]]
)
