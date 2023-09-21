{...}: {
  imports = [
    ./lsp.nix
    ./lualine.nix
    ./harpoon.nix
    ./nvim-tree.nix
    ./treesitter.nix
    ./telescope.nix
    ./completion.nix
    # ./which-key.nix
    ./comment-nvim.nix
    ./indent-blankline.nix
    ./gitsigns.nix
    ./nvim-autopairs.nix
  ];
}
