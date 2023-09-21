{...}: {
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      showBufferEnd = true;
      integrations = {
        telescope = true;
        treesitter = true;
        treesitter_context = true;
        nvimtree = true;
        harpoon = true;
      };
    };
  };
}
