{pkgs, ...}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      keymaps = {
        silent = true;
        diagnostic = {
          "]d" = "goto_next";
          "[d" = "goto_prev";
        };
        lspBuf = {
          gd = "definition";
          gy = "type_definition";
          gi = "implementation";
          gr = "references";
          "<leader>k" = "hover";
          "<leader>r" = "rename";
          "<leader>a" = "code_action";
        };
      };
      servers = {
        nil_ls = {
          enable = true;
          settings.formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--quiet" "-"];
        };
        bashls.enable = true;
        clangd.enable = true;
        lua-ls.enable = true;
        rust-analyzer = {
          enable = true;
          settings.diagnostics.experimental.enable = true;
        };
        java-language-server.enable = true;
      };
    };
    lsp-format.enable = true;
  };
}
