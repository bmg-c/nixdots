{...}: {
  programs.nixvim.plugins.trouble = {
    enable = true;
    actionKeys.hover = "<leader>k";
  };
}
