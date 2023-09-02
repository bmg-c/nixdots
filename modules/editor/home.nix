# neovim

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      lualine-nvim
      nvim-web-devicons
      nvim-tree-lua
      nvim-treesitter
      comment-nvim
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
