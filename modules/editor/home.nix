# neovim
{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      lualine-nvim
      nvim-web-devicons
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      comment-nvim
      nvim-lspconfig
      nvim-cmp
      luasnip
      cmp_luasnip
      friendly-snippets
      cmp-nvim-lsp
      telescope-nvim
      plenary-nvim
      noice-nvim
      formatter-nvim
      nvim-autopairs
      indent-blankline-nvim
      trouble-nvim
      harpoon
    ];
    extraPackages = with pkgs; [
      # Language Servers
      lua-language-server
      clang-tools
      nodePackages.bash-language-server
      nodePackages.pyright
      nil
      java-language-server
      # Formatters
      stylua
      yapf
      shfmt
      alejandra
      # google-java-format
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
