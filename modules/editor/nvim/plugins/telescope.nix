{pkgs, ...}: {
  programs.nixvim.maps = {
    normalVisualOp."<leader>f" = {
      action = ":Telescope find_files<CR>";
      silent = true;
    };
    normalVisualOp."<leader>F" = {
      action = ":Telescope file_browser<CR>";
      silent = true;
    };
    normalVisualOp."<leader>g" = {
      action = ":Telescope live_grep<CR>";
      silent = true;
    };
    normalVisualOp."<leader>b" = {
      action = ":Telescope buffers<CR>";
      silent = true;
    };

    # normalVisualOp."td" = {
    #   action = ":Telescope lsp_definitions<CR>";
    #   silent = true;
    # };
    # normalVisualOp."ty" = {
    #   action = ":Telescope lsp_type_definitions<CR>";
    #   silent = true;
    # };
    # normalVisualOp."th" = {
    #   action = ":Telescope diagnostics<CR>";
    #   silent = true;
    # };
    # normalVisualOp."ti" = {
    #   action = ":Telescope lsp_implementations<CR>";
    #   silent = true;
    # };
  };
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native = {
        enable = true;
        fuzzy = true;
        caseMode = "smart_case";
        overrideFileSorter = true;
        overrideGenericSorter = true;
      };
      file_browser = {
        enable = true;
        hijackNetrw = true;
        autoDepth = true;
        depth = 2;
        hideParentDir = false;
        # mappings = {
        #   i = {}
        # };
      };
    };
  };
  programs.nixvim.extraPackages = with pkgs; [
    fd # file_browser
    ripgrep # live_grep
  ];
}
