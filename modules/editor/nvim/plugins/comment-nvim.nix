{...}: {
  programs.nixvim.plugins.comment-nvim = {
    enable = true;
    mappings.basic = true;
    opleader = {
      block = "<C-b>";
      line = "<C-c>";
    };
    toggler = {
      block = "<C-b>";
      line = "<C-c>";
    };
  };
}
