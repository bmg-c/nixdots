{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        scrolloff = 9;
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        line-number = "relative";
        indent-guides.render = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
      keys.normal = import ./helix/keybindings/normal.nix;
      keys.insert = import ./helix/keybindings/insert.nix;
    };
  };
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
      formatter-nvim
      nvim-autopairs
      indent-blankline-nvim
      trouble-nvim
      harpoon
      nvim-jdtls
      # # # coc
      # coc-java
      # coc-sumneko-lua
      # coc-json
      # coc-python
    ];
    extraPackages = with pkgs; [
      # # Language Servers
      lua-language-server
      clang-tools # Also a formatter
      nodePackages.bash-language-server
      nodePackages.pyright
      nil
      jdt-language-server
      # # Formatters
      stylua
      yapf
      shfmt
      alejandra
      # google-java-format
    ];
    # coc = {
    #   enable = true;
    #   settings = {
    #     # "coc.preferences.snippets.enable" = true;
    #     "coc.preferences.extensionUpdateCheck" = "never";
    #     "sumneko-lua.serverDir" = "${pkgs.lua-language-server}/bin/lua-language-server";
    #   };
    #
    #
    # };
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
