local function map(m, k, v)
	vim.keymap.set(m, k, v, {})
end

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function ()
            vim.cmd("colorscheme catppuccin-mocha")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            require("lualine").setup({
                icons_enabled = true,
                theme = "catppuccin",
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function ()
            require("nvim-tree").setup()
        end,
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
}
