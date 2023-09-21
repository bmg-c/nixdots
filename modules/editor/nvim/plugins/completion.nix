{...}: {
  programs.nixvim = {
    options.completeopt = ["menu" "menuone" "noselect"];

    plugins = {
      luasnip.enable = true;

      lspkind = {
        enable = true;

        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
          };
        };
      };

      nvim-cmp = {
        enable = true;

        snippet.expand = "luasnip";

        completion.keywordLength = 1;

        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<Tab>" = {
            modes = ["i" "s"];
            action = ''              function(fallback)
                                        if cmp.visible() then
                                            cmp.select_next_item()
                                        elseif require('luasnip').expand_or_locally_jumpable() then
                                            require('luasnip').expand_or_jump()
                                        else
                                            fallback()
                                        end
                                    end'';
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = ''              function(fallback)
                          if cmp.visible() then
                              cmp.select_prev_item()
                          elseif require('luasnip').locally_jumpable(-1) then
                              require('luasnip').jump(-1)
                          else
                              fallback()
                          end
                      end'';
          };
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })";
        };

        sources = [
          {name = "path";}
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {
            name = "buffer";
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
        ];
      };
    };
  };
}
