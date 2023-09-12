{pkgs, ...}: let
  jdtls = import ../../pkgs/jdtls.nix;
in {
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
      keys.select = import ./helix/keybindings/select.nix;
    };
    languages.language = [
      {
        name = "lua";
        auto-format = true;
        formatter = {
          command = "stylua";
          args = ["-"];
        };
      }
      {
        name = "rust";
        auto-format = true;
        formatter = {
          command = "rustfmt";
        };
        config = {
          diagnostics.experimental.enable = true;
        };
      }
      {
        name = "c";
        auto-format = true;
        formatter = {
          command = "clang-format";
          args = ["-"];
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "alejandra";
          args = ["--quiet" "-"];
        };
      }
    ];
  };
  home.packages = with pkgs; [
    jdtls

    rust-analyzer
    rustfmt
    lldb

    clang-tools

    lua-language-server
    stylua

    nil
    alejandra

    nodePackages_latest.bash-language-server
  ];
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
