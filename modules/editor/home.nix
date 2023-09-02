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
    ];
    extraPackages = with pkgs; [
      # Language Servers
      lua-language-server
      clang-tools
      nodePackages.bash-language-server
      nodePackages.pyright
      nil
      # Formatters
      stylua
      yapf
      shfmt
      alejandra
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
